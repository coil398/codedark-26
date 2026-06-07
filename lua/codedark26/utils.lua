-- lua/codedark26/utils.lua
-- ユーティリティ関数（terminal colors 16色マッピング）

local M = {}

--- set_terminal_colors() — vim.g.terminal_color_0..15 を設定
--- v2 マッピング: 補完色 (#C586C0 等) を一切使わない。Focus パレットのみ。
--- index 5 と 13 が同色 (#d2a8ff) になるのは 2026-dark の Focus パレット構造上の制約で許容。
function M.set_terminal_colors()
  -- colors.lua を関数内で require（循環依存なし。utils.lua は colors.lua に依存しない構造）
  local colors = require('codedark26.colors')
  local c = colors.get_colors()

  -- 0: black — panel 背景
  vim.g.terminal_color_0  = c.vscPanelBack       -- '#191A1B'
  -- 1: red — errorForeground
  vim.g.terminal_color_1  = c.vscRed             -- '#f48771'
  -- 2: green — tag 緑
  vim.g.terminal_color_2  = c.vscTag             -- '#7ee787'
  -- 3: yellow — warning
  vim.g.terminal_color_3  = c.vscYellow          -- '#e5ba7d'
  -- 4: blue — constant 青
  vim.g.terminal_color_4  = c.vscConstant        -- '#79c0ff'
  -- 5: magenta — function 紫
  vim.g.terminal_color_5  = c.vscFunction        -- '#d2a8ff'
  -- 6: cyan — textLink (2026-dark UI 色。vscAccentLighter に対応するが UI 文脈として hex 維持)
  vim.g.terminal_color_6  = '#48A0C7'
  -- 7: white — 前景（ユーザー指示で現行設計のまま維持）
  vim.g.terminal_color_7  = c.vscLightGray       -- '#bfbfbf'
  -- 8: br black — secondary gray
  vim.g.terminal_color_8  = c.vscGray            -- '#8C8C8C'
  -- 9: br red — invalid 赤
  vim.g.terminal_color_9  = c.vscOrangeLight     -- '#ffa198'
  -- 10: br green — git added 緑
  vim.g.terminal_color_10 = c.vscGitAddedDecor   -- '#73c991'
  -- 11: br yellow — variable 橙
  vim.g.terminal_color_11 = c.vscVariable        -- '#ffa657'
  -- 12: br blue — accent light (2026-dark UI 色。vscAccentLight に対応するが UI 文脈として hex 維持)
  vim.g.terminal_color_12 = '#3994BC'
  -- 13: br magenta — v2: function 紫（v1 の補完色 #C586C0 を排除。2026-dark に紫は #d2a8ff のみ）
  --     index 5 と同色になるが Focus パレットの構造的制約として許容（README でも説明）
  vim.g.terminal_color_13 = c.vscFunction        -- '#d2a8ff'
  -- 14: br cyan — accent lightest (2026-dark UI 色。vscAccentLightest に対応するが UI 文脈として hex 維持)
  vim.g.terminal_color_14 = '#53A5CA'
  -- 15: br white — list.activeSelectionForeground (2026-dark UI 色)
  vim.g.terminal_color_15 = c.vscPmenuSelFront   -- '#ededed'
end

return M
