local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
	colorschemeName = "catppuccin-mocha"
end
vim.cmd.colorscheme(colorschemeName)

require('protean.keybinds')
require('protean.cmp')
require('protean.opts')
