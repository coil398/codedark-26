-- lua/codedark26/init.lua
-- codedark26: VS Code Dark 2026 (Focus) の Neovim カラースキーム
-- 公開 API: setup() / load()

local config = require('codedark26.config')
local theme  = require('codedark26.theme')
local utils  = require('codedark26.utils')

local codedark26 = {}

-- setup() を config.setup に委譲して公開
codedark26.setup = config.setup

--- load(style) — カラースキームを適用する
---@param style string|nil 'dark' または 'light'（現在は dark のみ対応）
function codedark26.load(style)
  if style then
    vim.o.background = (style == 'light') and 'light' or 'dark'
  end

  -- カラースキーム初期化の定型句
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
  end

  -- 24bit カラーを有効化（Lua ベーステーマ必須）
  vim.o.termguicolors = true

  -- カラースキーム名を登録（:colorscheme コマンドへの登録）
  vim.g.colors_name = 'codedark26'

  -- 全ハイライトグループを設定
  theme.set_highlights()

  -- terminal colors を設定（config.opts.terminal_colors が true の場合）
  if config.opts.terminal_colors then
    utils.set_terminal_colors()
  end
end

return codedark26
