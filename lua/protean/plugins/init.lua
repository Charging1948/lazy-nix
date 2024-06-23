return {
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  {
    "tpope/vim-fugitive",
  },
  {
    "tpope/vim-rhubarb",
  },

  -- Detect tabstop and shiftwidth automatically
  {
    "tpope/vim-sleuth",
  },
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      --[[ ----------------------------------------- ]]
      --[[ Uh-oh! We don't want to use mason on nix! ]]
      --[[ luckily we have our lazyAdd utility!      ]]
      --[[ We can use it to add true only if not     ]]
      --[[ loaded via nix.                           ]]
      --[[ When NOT loaded in nix                    ]]
      --[[ It returns the 1st value, otherwise,      ]]
      --[[ it returns the 2nd value.                 ]]
      --[[    (or nil if there wasn't one)            ]]
      --[[ ----------------------------------------- ]]
      {
        "williamboman/mason.nvim",
        enabled = require("nixCatsUtils.lazyCat").lazyAdd(true, false),
      },
      {
        "williamboman/mason-lspconfig.nvim",
        enabled = require("nixCatsUtils.lazyCat").lazyAdd(true, false),
      },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        "j-hui/fidget.nvim",
        opts = {},
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      {
        "folke/neodev.nvim",
      },
      {
        "folke/neoconf.nvim",
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      --[[ ------------------------------------- ]]
      --[[ Uh-oh! This one has a different name! ]]
      --[[ Set the name to the actual filename   ]]
      --[[ that was generated by nix. Lazy will  ]]
      --[[ use the same name in non-nix installs ]]
      --[[ this ensures that your config won't   ]]
      --[[ break from this on non-nix OS targets ]]
      --[[ ------------------------------------- ]]
      {
        "L3MON4D3/LuaSnip",
        name = "luasnip",
      },
      {
        "saadparwaiz1/cmp_luasnip",
      },

      -- Adds LSP completion capabilities
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "hrsh7th/cmp-path",
      },
      -- Adds a number of user-friendly snippets
      {
        "rafamadriz/friendly-snippets",
      },
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    opts = {},
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to next hunk" })

        map({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to previous hunk" })

        -- Actions
        -- visual mode
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "stage git hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "reset git hunk" })
        -- normal mode
        map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = false })
        end, { desc = "git blame line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "git diff against last commit" })

        -- Toggles
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
      end,
    },
  },

  {
    -- Theme inspired by Atom (disabled)
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
    priority = 1000,
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    opts = {},
    name = "comment.nvim",
  },

  {
    "m-demare/hlargs.nvim",
    name = "hlargs",
    config = function()
      require("hlargs").setup({
        color = "#32a88f",
      })
      vim.cmd([[
        highlight clear @lsp.type.parameter
        highlight link @lsp.type.parameter Hlargs
      ]])
    end,
  },
}
