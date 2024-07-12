local null_ls = require("null-ls")
local none_ls = require("none-ls")
local bf = null_ls.builtins.formatting
local bc = null_ls.builtins.completion
local bd = null_ls.builtins.diagnostics
local nd = none_ls.diagnostics
local nc = none_ls.code_actions
local nf = none_ls.formatting

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
    bf.dart,
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
    bc.gomodifytags,
    bc.refactoring,
    bc.statix,
    bc.impl,
    bc.ts_node_action,

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

    nd.eslint_d,

    nc.eslint_d,

    nf.eslint_d,
  },
})
