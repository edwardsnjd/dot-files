import { Type } from "typebox";
import { Text } from "@earendil-works/pi-tui";

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "web_fetch",
    label: "Web Fetch",
    description: "Fetch a URL from the web",
    promptSnippet: "Fetch a URL from the web",
    promptGuidelines: [
      "Use web_fetch if you need to fetch a URL from the web.",
    ],
    parameters: Type.Object({
      url: Type.String({ description: "URL to fetch" }),
    }),
    async execute(_toolCallId, params, signal) {
      if (signal?.aborted) {
        return { content: [{ type: "text", text: "Cancelled" }] };
      }
      const result = await pi.exec('web-fetch', [params.url], { signal });
      const output = result.stdout + result.stderr;
      return { content: [{ type: "text", text: output }] };
    },
    renderCall(args, theme) {
      const text = theme.fg("toolTitle", theme.bold("web_fetch ")) + theme.fg("accent", args.url);
      return new Text(text, 0, 0);
    },
  });

  pi.registerTool({
    name: "web_search",
    label: "Web Search",
    description: "Search the web for recent information",
    promptSnippet: "Search the web for recent information",
    promptGuidelines: [
      "Use web_search if you need to find/search/research live information.",
    ],
    parameters: Type.Object({
      query: Type.String({ description: "Search query" }),
    }),
    async execute(_toolCallId, params, signal) {
      if (signal?.aborted) {
        return { content: [{ type: "text", text: "Cancelled" }] };
      }
      const result = await pi.exec('web-search', [params.query], { signal });
      const output = result.stdout + result.stderr;
      return { content: [{ type: "text", text: output }] };
    },
    renderCall(args, theme) {
      const text = theme.fg("toolTitle", theme.bold("web_search ")) + theme.fg("accent", args.query);
      return new Text(text, 0, 0);
    },
  });
}
