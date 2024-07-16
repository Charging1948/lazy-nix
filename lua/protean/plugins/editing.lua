return {

  -- disables hungry features for files larget than 2MB
  { "LunarVim/bigfile.nvim" },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- add/delete/change can be done with the keymaps
  -- ys{motion}{char}, ds{char}, and cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  { -- format things as tables
    "godlygeek/tabular",
  },

  {
    "leon-richardt/comment-highlights.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    cmd = "CHToggle",
    keys = {
      {
        "<leader>tc",
        function()
          require("comment-highlights").toggle()
        end,
        desc = "[T]oggle [C]omment highlighting",
      },
    },
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    enabled = false,
    event = "BufEnter",
    config = function()
      require("conform").setup({
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          typst = { "typstfmt" },
          bib = { "bibtex-tidy" },
          nix = { "alejandra" },
        },
        -- formatters = {
        --   mystylua = {
        --     command = "stylua",
        --     args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
        --   },
        -- },
      })
      -- Customize the "injected" formatter
      require("conform").formatters.injected = {
        -- Set the options field
        options = {
          -- Set to true to ignore errors
          ignore_errors = false,
          -- Map of treesitter language to file extension
          -- A temporary file name with this extension will be generated during formatting
          -- because some formatters care about the filename.
          lang_to_ext = {
            bash = "sh",
            bib = "bib",
            c_sharp = "cs",
            elixir = "exs",
            javascript = "js",
            julia = "jl",
            latex = "tex",
            lua = "lua",
            markdown = "md",
            nix = "nix",
            python = "py",
            r = "r",
            ruby = "rb",
            rust = "rs",
            teal = "tl",
            typst = "typ",
            typescript = "ts",
          },
          -- Map of treesitter language to formatters to use
          -- (defaults to the value from formatters_by_ft)
          lang_to_formatters = {},
        },
      }
    end,
  },

  {
    "mfussenegger/nvim-lint",
    enabled = false,
    config = function()
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- INFO: try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require("lint").try_lint()
        end,
      })
    end,
  },

  { -- generate docstrings
    "danymat/neogen",
    cmd = { "Neogen" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },

  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    name = "gx",
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    submodules = false, -- not needed, submodules are required only for tests
    config = true,
    opts = {
      handler_options = {
        -- you can select between google, bing, duckduckgo, and ecosia
        search_engine = "https://www.startpage.com/do/dsearch?q=",
      },
    },
  },

  -- interactive global search and replace
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
