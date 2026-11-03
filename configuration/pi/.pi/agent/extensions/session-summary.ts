import { writeSync } from "node:fs";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_shutdown", (event, ctx) => {
    if (ctx.mode !== "print" || event.reason !== "quit") return;

    let turns = 0;
    let toolCalls = 0;
    for (const entry of ctx.sessionManager.getBranch()) {
      if (entry.type !== "message" || entry.message.role !== "assistant") continue;
      turns += 1;
      toolCalls += entry.message.content.filter((block) => block.type === "toolCall").length;
    }

    const usage = ctx.getContextUsage();
    const startedAt = ctx.sessionManager.getHeader()?.timestamp;
    const durationMs = startedAt ? Date.now() - Date.parse(startedAt) : null;
    const model = ctx.model?.id ?? null;
    const tools = pi.getActiveTools();
    const skills = pi
      .getCommands()
      .filter((command) => command.source === "skill")
      .map((command) => command.name.replace(/^skill:/, ""));
    const contextTokens = usage?.tokens ?? null;
    const contextWindow = usage?.contextWindow ?? null;
    const contextPercent = usage?.percent ?? null;

    const summary = {
      turns,
      toolCalls,
      durationMs,
      model,
      tools,
      skills,
      contextTokens,
      contextWindow,
      contextPercent,
    };

    process.once("exit", () => {
      writeSync(process.stderr.fd, `${JSON.stringify(summary)}\n`);
    });
  });
}
