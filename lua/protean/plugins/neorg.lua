return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.integrations.telescope"] = {},
      },
    },
    build = require("nixCatsUtils.lazyCat").lazyAdd(nil, false),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
      "luarocks.nvim",
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    build = require("nixCatsUtils.lazyCat").lazyAdd(nil, false),
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
}
