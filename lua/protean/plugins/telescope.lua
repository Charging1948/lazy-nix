return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        --[[ --------------------------------- ]]
        --[[ Uh-oh! This one has a build step! ]]
        --[[ Nix has already done that for us. ]]
        --[[ Use the lazyAdd function to       ]]
        --[[ disable build steps on nix.       ]]
        --[[ --------------------------------- ]]
        build = require("nixCatsUtils.lazyCat").lazyAdd("make"),
        cond = require("nixCatsUtils.lazyCat").lazyAdd(function()
          return vim.fn.executable("make") == 1
        end),
      },
      "mrcjkb/telescope-manix",
      {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-cheat.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
        },
      },
      {
        "jvgrootveld/telescope-zoxide",
        dependencies = {
          "nvim-lua/popup.nvim",
        },
      },
    },
    config = function()
      local t = require("telescope")
      t.setup({
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      })
      t.load_extension("cheat")
      t.load_extension("zoxide")
      t.load_extension("undo")
      t.load_extension("ui-select")
      t.load_extension("dap")
      t.load_extension("manix")
      t.load_extension("fzf")
    end,
  },
}
