import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Editor, type EditorTheme, Key, matchesKey, wrapTextWithAnsi } from "@earendil-works/pi-tui";
import { Type } from "typebox";

const QuestionSchema = Type.Object({
	text: Type.String({ description: "Question text" }),
	clarification: Type.Optional(Type.String({ description: "Optional clarification text" })),
	suggestedAnswer: Type.Optional(Type.String({ description: "Optional brief suggested answer" })),
});

const ParamsSchema = Type.Object({
	questions: Type.Array(QuestionSchema, {
		description: "Questions to ask the user, one at a time",
		minItems: 1,
	}),
});

type Question = { text: string; clarification?: string; suggestedAnswer?: string };
type Answer = { index: number; question: string; answer: string };
type Outcome = { cancelled: boolean; answers: Answer[] };

/** Interactive one-question-at-a-time flow. Enter = next, Alt+P/N = back/forward, Alt+F = finish, Esc = cancel. */
async function ask(ctx: any, questions: Question[]): Promise<Outcome> {
	if (!ctx.hasUI) return { cancelled: true, answers: [] };

	if (ctx.mode !== "tui") {
		const answers: Answer[] = [];
		for (const [i, q] of questions.entries()) {
			const answer = await ctx.ui.input(`Q${i + 1} of ${questions.length}\n\nQ${i + 1}: ${q.text}`, q.suggestedAnswer);
			if (answer === undefined) return { cancelled: true, answers };
			answers.push({ index: i + 1, question: q.text, answer });
		}
		return { cancelled: false, answers };
	}

	const result = await ctx.ui.custom<Outcome>((tui: any, theme: any, _kb: any, done: (v: Outcome) => void) => {
		const answers = new Map<number, string>();
		let current = 0;
		let cache: string[] | undefined;

		const style = (c: string) => (t: string) => theme.fg(c, t);
		const editorTheme: EditorTheme = {
			borderColor: style("accent"),
			selectList: {
				selectedPrefix: style("accent"),
				selectedText: style("accent"),
				description: style("muted"),
				scrollInfo: style("dim"),
				noMatch: style("warning"),
			},
		};
		const editor = new Editor(tui, editorTheme);
		const load = () => editor.setText(answers.get(current) ?? "");
		const save = (text = editor.getText()) => answers.set(current, text);
		const redraw = () => {
			cache = undefined;
			tui.requestRender();
		};

		const finish = (cancelled: boolean) =>
			done({
				cancelled,
				answers: questions.map((q, i) => ({ index: i + 1, question: q.text, answer: answers.get(i) ?? "" })),
			});

		const go = (delta: number) => {
			save();
			const next = current + delta;
			if (next < 0 || next >= questions.length) return finish(false);
			current = next;
			load();
			redraw();
		};

		editor.onSubmit = (text) => {
			save(text);
			if (current === questions.length - 1) return finish(false);
			current += 1;
			load();
			redraw();
		};

		load();

		return {
			render(width: number): string[] {
				if (cache) return cache;
				const w = Math.max(1, width);
				const q = questions[current];
				const wrap = (color: string, text: string) => wrapTextWithAnsi(theme.fg(color, text), w);

				cache = [
					theme.fg("accent", "─".repeat(w)),
					...wrap("accent", `Q${current + 1} of ${questions.length}`),
					...wrap("text", `Q${current + 1}: ${q.text}`),
					...(q.clarification ? wrap("muted", q.clarification) : []),
					...(q.suggestedAnswer ? wrap("muted", `Suggestion: ${q.suggestedAnswer}`) : []),
					"",
					...editor.render(Math.max(1, w - 2)).map((line) => ` ${line}`),
					"",
					...wrap("dim", "Enter: next • Alt+P/Alt+N: back/forward • Alt+F: finish • Esc: cancel"),
					theme.fg("accent", "─".repeat(w)),
				];
				return cache;
			},
			handleInput(data: string) {
				if (matchesKey(data, Key.escape)) return finish(true);
				if (matchesKey(data, Key.alt("p"))) return go(-1);
				if (matchesKey(data, Key.alt("n"))) return go(1);
				if (matchesKey(data, Key.alt("f"))) {
					save();
					return finish(false);
				}
				editor.handleInput(data);
				redraw();
			},
			invalidate() {
				cache = undefined;
			},
		};
	});

	return result ?? { cancelled: true, answers: [] };
}

const toPreview = (answers: Answer[]) =>
	answers.map((a) => `Q${a.index}: ${a.question}\nA${a.index}: ${a.answer}`).join("\n\n");

/** Only answers are sent to the model, never the question text. */
const toSubmission = (answers: Answer[]) => answers.map((a) => `Q${a.index}: ${a.answer}`).join("\n");

function parseQuestions(raw: string): Question[] {
	const parsed = JSON.parse(raw);
	const list: unknown[] = Array.isArray(parsed) ? parsed : (parsed?.questions ?? []);
	const questions = list.filter((q: any) => typeof q?.text === "string" && q.text.trim()) as Question[];
	if (!questions.length) throw new Error("No valid questions found");
	return questions;
}

export default function questionnaireTool(pi: ExtensionAPI) {
	pi.registerTool({
		name: "ask_questions",
		label: "Ask Questions",
		description:
			"Ask the user a list of questions one-by-one and collect answers. Use when you need clarifications directly from the user.",
		promptSnippet: "Collect user answers for multiple questions, one question at a time",
		promptGuidelines: ["Use ask_questions when you need direct user input across multiple specific questions."],
		parameters: ParamsSchema,
		executionMode: "sequential",

		async execute(_id, params, _signal, _onUpdate, ctx) {
			if (!ctx.hasUI) {
				return {
					content: [{ type: "text", text: "Cannot ask questions: no interactive UI available." }],
					details: { cancelled: true, answers: [] } satisfies Outcome,
					isError: true,
				};
			}

			const result = await ask(ctx, params.questions as Question[]);
			const text = result.cancelled
				? "Questionnaire cancelled."
				: `Collected ${result.answers.length} answer(s):\n\n${toPreview(result.answers)}`;

			return { content: [{ type: "text", text }], details: result };
		},
	});

	pi.registerCommand("ask", {
		description: "Ask yourself a set of questions, then submit the answers",
		handler: async (args, ctx) => {
			if (!ctx.hasUI) {
				ctx.ui.notify("/ask needs an interactive UI", "error");
				return;
			}

			const raw =
				args?.trim() ||
				(await ctx.ui.editor(
					"Enter questions as JSON array (or { questions: [...] })",
					'[\n\t{ "text": "What output format do you prefer?", "suggestedAnswer": "Bullet points" },\n\t{ "text": "Any hard constraints?" }\n]',
				)) ||
				"";

			if (!raw.trim()) return ctx.ui.notify("Cancelled", "info");

			let questions: Question[];
			try {
				questions = parseQuestions(raw);
			} catch (error) {
				return ctx.ui.notify(`Invalid questions JSON: ${(error as Error).message}`, "error");
			}

			const result = await ask(ctx, questions);
			if (result.cancelled) return ctx.ui.notify("Question flow cancelled", "warning");

			const confirmed = await ctx.ui.confirm(
				"Preview (read-only)",
				`${toPreview(result.answers)}\n\nSubmit answers now?`,
			);
			if (!confirmed) return ctx.ui.notify("Submission cancelled", "info");

			pi.sendUserMessage(toSubmission(result.answers));
			ctx.ui.notify("Submitted answers to model.", "info");
		},
	});
}
