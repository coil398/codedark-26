-- lua/codedark26/config.lua
-- Setup オプション管理
-- codedark26: VS Code Dark 2026 (Focus) を Neovim に移植したカラースキーム

local M = {}

M.opts = {
  -- テーマバリエーション（将来の light 受け口）
  style             = 'dark',
  -- 背景を透過にする（ターミナル背景を活かす）
  transparent       = false,
  -- コメントをイタリック表示（2026-dark は fontStyle 指定なし → デフォルト false）
  italic_comments   = false,
  -- インライン型ヒントをイタリック表示
  italic_inlayhints = false,
  -- @markup.link.* を下線表示
  underline_links   = false,
  -- nvim-tree 背景を無効化（親ウィンドウ背景を見せる）
  disable_nvimtree_bg = false,
  -- :terminal の 0-15 色をカラースキーム適用
  terminal_colors   = true,
  -- 色パレット値の上書き（例: { vscBack = '#000000' }）
  color_overrides   = {},
  -- ハイライトグループの上書き（例: { Normal = { fg = '#ffffff' } }）
  group_overrides   = {},
}

--- setup() — オプションをデフォルトにマージして M.opts を更新
---@param opts table|nil ユーザー指定オプション
function M.setup(opts)
  M.opts = vim.tbl_extend('force', M.opts, opts or {})
  -- transparent = true 時は背景を NONE に強制
  if M.opts.transparent then
    M.opts.color_overrides = vim.tbl_extend(
      'force',
      M.opts.color_overrides or {},
      { vscBack = 'NONE' }
    )
  end
end

-- デフォルト値で初期化（モジュール読み込み時に実行）
M.setup()

return M
