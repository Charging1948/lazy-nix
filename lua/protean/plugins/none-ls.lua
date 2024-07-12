return {
  "nvimtools/none-ls.nvim",
  config = function()
    require("protean.configs.null-ls")
  end,
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
}
