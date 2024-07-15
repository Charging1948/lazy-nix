local lspconfig = require("lspconfig")
local servers = {
  "tsserver",
}
local cmp_nvim_lsp = require("cmp_nvim_lsp")

lspconfig.marksman.setup {
  filetypes = { "markdown", "markdown.mdx", "quarto" },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  }
end
