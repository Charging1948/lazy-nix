local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
  colorschemeName = "catppuccin-mocha"
end
vim.schedule(function()
  vim.cmd.colorscheme(colorschemeName)
end)

require("protean.keybinds")
require("protean.cmp")
require("protean.opts")
