import {
  BaseConfig,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.2/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v0.0.2/deps.ts";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{
    plugins: Plugin[];
    stateLines: string[];
  }> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const dotfilesDir = '~/dotfiles';

    const normalPlugins = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: await fn.expand(args.denops, dotfilesDir + "/dein.toml"),
      },
    ) as Plugin[];

    const lazyPlugins = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: await fn.expand(args.denops, dotfilesDir + "/dein_lazy.toml"),
        options: {
          lazy: true,
        },
      },
    ) as Plugin[];

    const dduPlugins = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: await fn.expand(args.denops, dotfilesDir + "/dein_ddu.toml"),
        options: {
          lazy: true,
        },
      },
    ) as Plugin[];

    const ddcPlugins = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: await fn.expand(args.denops, dotfilesDir + "/dein_ddc.toml"),
        options: {
          lazy: true,
        },
      },
    ) as Plugin[];

    const recordPlugins: Record<string, Plugin> = {};
    for (const plugin of normalPlugins) {
      recordPlugins[plugin.name] = plugin;
    }

    for (const plugin of lazyPlugins) {
      recordPlugins[plugin.name] = plugin;
    }

    for (const plugin of dduPlugins) {
      recordPlugins[plugin.name] = plugin;
    }

    for (const plugin of ddcPlugins) {
      recordPlugins[plugin.name] = plugin;
    }

    const stateLines = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as string[];

    return {
      plugins: Object.values(recordPlugins),
      stateLines,
    };
  }
}
