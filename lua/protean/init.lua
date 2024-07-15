local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
  colorschemeName = "catppuccin-mocha"
end
vim.schedule(function()
  vim.cmd.colorscheme(colorschemeName)
end)

require("protean.lsp")
require("protean.keybinds")
require("protean.opts")
require("protean.autocmd")
