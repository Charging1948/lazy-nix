local null_ls = require("null-ls")
local bf = null_ls.builtins.formatting
local bc = null_ls.builtins.completion
local bca = null_ls.builtins.code_actions
local bd = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    --
    bf.alejandra,
    bf.stylua,
    bf.black,
    bf.isort,
    bf.prettierd,
    bf.prisma_format,
    bf.bibclean,
    bf.dart_format,
    bf.gofumpt,
    bf.goimports_reviser,
    bf.golines,
    bf.gleam_format,
    bf.mdformat,
    bf.just,
    bf.shellharden,
    bf.shfmt,
    bf.typstfmt,

    bc.luasnip,

    bca.gomodifytags,
    bca.refactoring,
    bca.statix,
    bca.impl,
    bca.ts_node_action,

    bd.actionlint,
    bd.deadnix,
    bd.statix,
    bd.dotenv_linter,
    bd.editorconfig_checker,
    bd.markdownlint_cli2,
    bd.mypy,
    bd.ltrs,
    bd.vale,
    bd.selene,

    require("none-ls.diagnostics.eslint_d"),
    require("none-ls.code_actions.eslint_d"),
    require("none-ls.formatting.eslint_d"),
  },
})
