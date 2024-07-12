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
}
