local colorschemeName = nixCats("colorscheme")

local M = {}

if colorschemeName:match("^catppuccin") ~= nil then
  local palette = require("catppuccin.palettes").get_palette(colorschemeName:gsub("catppuccin%-", ""))
  M.colors = {
    bg = palette.base,
    fg = palette.text,
    yellow = palette.yellow,
    cyan = palette.sky,
    darkblue = palette.lavender,
    green = palette.green,
    orange = palette.peach,
    violet = palette.pink,
    magenta = palette.mauve,
    blue = palette.blue,
    red = palette.red,
  }
else
  M.colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }
end

return M
