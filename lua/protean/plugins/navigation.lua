return {

  {
    "smoka7/hop.nvim",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    event = "VeryLazy",
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").AFTER_CURSOR,
            current_line_only = true,
          }, { remap = true })
        end,
      },
      {
        "F",
        mode = { "n", "x", "o" },
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").BEFORE_CURSOR,
            current_line_only = true,
          }, { remap = true })
        end,
      },
      {
        "t",
        mode = { "n", "x", "o" },
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").AFTER_CURSOR,
            current_line_only = true,
            hint_offset = -1,
          }, { remap = true })
        end,
      },
      {
        "T",
        mode = { "n", "x", "o" },
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").BEFORE_CURSOR,
            current_line_only = true,
            hint_offset = -1,
          }, { remap = true })
        end,
      },
    },
  },

  {
    "SmithesP/nvim-navbuddy",
    keys = {
      {
        "<leader>os",
        mode = { "n" },
        desc = "[O]pen File [S]tructure",
        function()
          require("nvim-navbuddy").open()
        end,
      },
    },
  },

  -- {
  --   "folke/flash.nvim",
  --   enabled = false,
  --   event = "VeryLazy",
  --   opts = {
  --     modes = {
  --       search = {
  --         enabled = false,
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "s",
  --       mode = { "n", "x", "o" },
  --       function()
  --         require("flash").jump()
  --       end,
  --     },
  --     {
  --       "S",
  --       mode = { "o", "x" },
  --       function()
  --         require("flash").treesitter()
  --       end,
  --     },
  --   },
  -- },
}
