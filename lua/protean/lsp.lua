--[[ ------------------------------------- ]]
--[[ Handling mason is covered in the help ]]
--[[ See :help nixCats.luaUtils.mason      ]]
--[[ ------------------------------------- ]]
-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
if not require("nixCatsUtils").isNixCats then
  require("mason").setup()
  require("mason-lspconfig").setup()
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  gopls = {},
  marksman = {
    filetypes = { "markdown", "markdown.mdx", "quarto" },
  },
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  html = { filetypes = { "html", "twig", "hbs" } },
  nixd = {},
  nil_ls = {},
  ltex = {},

  lua_ls = {
    Lua = {
      formatters = {
        ignoreComments = true,
      },
      signatureHelp = { enabled = true },
      diagnostics = {
        globals = { "nixCats" },
      },
    },
    workspace = {
      checkThirdParty = true,
      library = {
        vim.env.VIMRUNTIME,
      },
    },
    telemetry = { enabled = false },
    filetypes = { "lua" },
  },
}

local on_attachs = {
  ltex = function(client, bufnr)
    require("ltex-utils").on_attach(bufnr)
  end,
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

--[[ ------------------------------------- ]]
--[[ Handling mason is covered in the help ]]
--[[ See :help nixCats.luaUtils.mason      ]]
--[[ ------------------------------------- ]]
if require("nixCatsUtils").isNixCats then
  for server_name, _ in pairs(servers) do
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attachs[server_name] or nil,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      cmd = (servers[server_name] or {}).cmd,
      root_pattern = (servers[server_name] or {}).root_pattern,
    })
  end
else
  -- Ensure the servers above are installed
  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attachs[server_name] or nil,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      })
    end,
  })
end
