export default function (pi: any) {
  pi.registerCommand("show-endpoint", {
    description: "Show the selected model's endpoint",
    handler: async (_args: string, ctx: any) => {
      const m = ctx.model;
      ctx.ui.notify(JSON.stringify({
        provider: m?.provider,
        model: m?.id,
        api: m?.api,
        baseUrl: m?.baseUrl
      }, null, 2), "info");
    }
  });
}
