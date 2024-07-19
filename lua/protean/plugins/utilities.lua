return {
  {
    "laytan/cloak.nvim",
    opts = {
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = { "=.+" },
          replace = nil,
        },
      },
    },
    keys = {
      {
        "<leader>tC",
        "<cmd>CloakToggle<cr>",
        mode = { "n" },
        desc = "[T]oggle [C]loaking of secrets",
      },
      {
        "<leader>tP",
        "<cmd>CloakPreviewLine<cr>",
        mode = { "n" },
        desc = "[T]oggle [P]review secret in current line",
      },
    },
  },
  {
    "jhofscheier/ltex-utils.nvim",
    name = "ltex-utils",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      dictionary = {
        path = vim.api.nvim_call_function("stdpath", { "state" }) .. "/ltex/",
      },
    },
  },
  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    opts = {},
  },
}
