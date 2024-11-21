import {
  ContextBuilder,
  ExtOptions,
  Plugin,
} from "jsr:@shougo/dpp-vim@~3.0.0/types";
import {
  BaseConfig,
  type ConfigReturn,
  type MultipleHook,
} from "jsr:@shougo/dpp-vim@~3.0.0/config";
import { Protocol } from "jsr:@shougo/dpp-vim@~3.0.0/protocol";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~3.0.0/utils";

import type {
  Ext as LazyExt,
  LazyMakeStateResult,
  Params as LazyParams,
} from "jsr:@shougo/dpp-ext-lazy@~1.5.0";
import type {
  Ext as LocalExt,
  Params as LocalParams,
} from "jsr:@shougo/dpp-ext-local@~1.3.0";
import type {
  Ext as PackspecExt,
  Params as PackspecParams,
} from "jsr:@shougo/dpp-ext-packspec@~1.3.0";
import type {
  Ext as TomlExt,
  Params as TomlParams,
} from "jsr:@shougo/dpp-ext-toml@~1.3.0";

import type { Denops } from "jsr:@denops/std@~7.1.0";
import * as fn from "jsr:@denops/std@~7.1.0/function";

import { expandGlob } from "jsr:@std/fs@~1.0.0/expand-glob";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
  }): Promise<ConfigReturn> {
    const BASE_DIR = await fn.expand(args.denops, '~/dotfiles');
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, Plugin> = {};
    const hooksFiles: string[] = [];
    let multipleHooks: MultipleHook[] = [];

    const [tomlExt, tomlOptions, tomlParams]: [
      TomlExt | undefined,
      ExtOptions,
      TomlParams,
    ] = await args.denops.dispatcher.getExt(
      "toml",
    ) as [TomlExt | undefined, ExtOptions, TomlParams];

    if (tomlExt) {
      const action = tomlExt.actions.load;
      const tomlPromises = [
        { path: `${BASE_DIR}/dein.toml`, lazy: false, }
        { path: `${BASE_DIR}/dein_lazy.toml`, lazy: true, }
        { path: `${BASE_DIR}/dein_ddu.toml`, lazy: true, }
        { path: `${BASE_DIR}/dein_dcc.toml`, lazy: true, }
      ].map((tomlFile) =>
        action.callback({
          denops: args.denops,
          context,
          options,
          protocols,
          extOptions: tomlOptions,
          extParams: tomlParams,
          actionParams: {
            path: tomlFile.path,
            options: {
              lazy: tomlFile.lazy,
            },
          },
        })
      );
      const tomls = await Promise.all(tomlPromises);
      for (const toml of tomls) {
        for (const plugin of toml.plugins ?? []) {
          recordPlugins[plugin.name] = plugin;
        }

        if (toml.ftplugins) {
          mergeFtplugins(ftplugins, toml.ftplugins);
        }
        if (toml.multiple_hooks) {
          multipleHooks = multipleHooks.concat(toml.multiple_hooks);
        }
        if (toml.hooks_file) {
          hooksFiles.push(toml.hooks_file);
        }
      }
    }

    const [lazyExt, lazyOptions, lazyParams]: [
      LazyExt | undefined,
      ExtOptions,
      LazyParams,
    ] = await args.denops.dispatcher.getExt(
      "lazy",
    ) as [LazyExt | undefined, ExtOptions, PackspecParams];
    let lazyResult: LazyMakeStateResult | undefined = undefined;
    if (lazyExt) {
      const action = lazyExt.actions.makeState;
      lazyResult = await action.callback({
        args.denops,
        context,
        options,
        protocols,
        extOptions: lazyOptions,
        extParams: lazyParams,
        actioParams: {
          plugins: Object.values(recordPlugins),
        },
      });
    }
    const checkFiles =[];
    for await (const file of expandGlob(`${BASE_DIR}/*`)) {
      checkFiles.push(file.path);
    }

    return {
      checkFiles,
      ftplugins,
      hooksFiles,
      multipleHooks,
      plugins: lazyResult?.plugins ?? [],
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
