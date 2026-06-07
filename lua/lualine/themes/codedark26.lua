-- lua/lualine/themes/codedark26.lua
-- lualine テーマ: mode 別 a/b/c セクション色
-- codedark26: VS Code Dark 2026 (Focus) の Neovim カラースキーム

local config = require('codedark26.config')
local colors = require('codedark26.colors')
local c = colors.get_colors()

-- c セクション背景: transparent 時は NONE
local c_bg = config.opts.transparent and 'NONE' or c.vscPanelBack

local theme = {
  -- normal: vscAccent (#297AA0)
  normal = {
    a = { fg = '#FFFFFF',          bg = c.vscAccent,         gui = 'bold' },
    b = { fg = c.vscStatusFront,   bg = c.vscStatusBack },
    c = { fg = c.vscStatusFront,   bg = c_bg },
  },
  -- insert: vscGitAdded (#73c991)
  insert = {
    a = { fg = '#000000',          bg = c.vscGitAddedDecor,  gui = 'bold' },
    b = { fg = c.vscStatusFront,   bg = c.vscStatusBack },
    c = { fg = c.vscStatusFront,   bg = c_bg },
  },
  -- visual: vscFunction (#d2a8ff)
  visual = {
    a = { fg = '#000000',          bg = c.vscFunction,       gui = 'bold' },
    b = { fg = c.vscStatusFront,   bg = c.vscStatusBack },
    c = { fg = c.vscStatusFront,   bg = c_bg },
  },
  -- replace: vscRed (#f48771)
  replace = {
    a = { fg = '#000000',          bg = c.vscRed,            gui = 'bold' },
    b = { fg = c.vscStatusFront,   bg = c.vscStatusBack },
    c = { fg = c.vscStatusFront,   bg = c_bg },
  },
  -- command: vscYellow (#e5ba7d)
  command = {
    a = { fg = '#000000',          bg = c.vscYellow,         gui = 'bold' },
    b = { fg = c.vscStatusFront,   bg = c.vscStatusBack },
    c = { fg = c.vscStatusFront,   bg = c_bg },
  },
  -- inactive (非フォーカス)
  inactive = {
    a = { fg = c.vscGray,          bg = c.vscPanelBack },
    b = { fg = c.vscGray,          bg = c.vscPanelBack },
    c = { fg = c.vscGray,          bg = c_bg },
  },
}

return theme
