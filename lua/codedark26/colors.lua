-- lua/codedark26/colors.lua
-- v2 実使用色の母集合（2026-dark.json 由来の色のみ）
-- dark_plus/dark_vs 由来の補完色（Type緑/Control紫/Number緑系/Escape金/CssProperty青/
-- Operator白 等）は一切定義しない（Focus 統一の機械チェックゲート）

local M = {}

function M.get_colors()
  local dark = {
    -- =====================================================================
    -- エディタ基本背景・前景
    -- =====================================================================
    vscBack             = '#121314',   -- editor.background
    vscFront            = '#BBBEBF',   -- editor.foreground
    vscPanelBack        = '#191A1B',   -- sideBar/panel/activityBar background
    vscMenuBack         = '#202122',   -- menu.background

    -- =====================================================================
    -- テキスト系グレー
    -- =====================================================================
    vscGray             = '#8C8C8C',   -- titleBar.inactiveForeground / breadcrumb
    vscMediumGray       = '#555555',   -- disabledForeground / input.placeholder
    vscDarkGray         = '#444444',   -- 非フォーカス非アクティブタブ fg
    vscLightGray        = '#bfbfbf',   -- widget.foreground / suggestWidget.foreground
    vscIndentGuide      = '#838485',   -- editorIndentGuide.background (4D alpha → ソリッド代用)

    -- =====================================================================
    -- ボーダー / セパレータ
    -- =====================================================================
    vscBorder           = '#2A2B2C',   -- activityBar.border / sideBar.border (2A2B2CFF)
    vscBorderLight      = '#333536',   -- button.border / checkbox.border

    -- =====================================================================
    -- アクセント（ブルー系）
    -- =====================================================================
    vscAccent           = '#297AA0',   -- button.background / lualine normal mode
    vscAccentLight      = '#3994BC',   -- focusBorder base / badge.background
    vscAccentLighter    = '#48A0C7',   -- textLink.foreground / list.highlightForeground
    vscAccentLightest   = '#53A5CA',   -- textLink.activeForeground

    -- =====================================================================
    -- 選択・ハイライト（アルファ付き色: ベース #RRGGBB のみ保存、blend は theme.lua で指定）
    -- =====================================================================
    vscSelection        = '#276782',   -- editor.selectionBackground ベース (dd=87% → blend=13)
    vscBracketMatch     = '#3994BC',   -- editorBracketMatch.background ベース (55=33% → blend=67)
    vscListActive       = '#3994BC',   -- list.activeSelectionBackground ベース (26=15% → blend=85)

    -- =====================================================================
    -- Diff 背景ベース
    -- =====================================================================
    vscDiffAddLine      = '#347d39',   -- diffEditor.insertedLineBackground ベース (26=15% → blend=85)
    vscDiffAddText      = '#57ab5a',   -- diffEditor.insertedTextBackground ベース (4d=30% → blend=70)
    vscDiffDelLine      = '#c93c37',   -- diffEditor.removedLineBackground ベース (26=15% → blend=85)
    vscDiffDelText      = '#f47067',   -- diffEditor.removedTextBackground ベース (4d=30% → blend=70)

    -- =====================================================================
    -- カーソル / 行ハイライト
    -- =====================================================================
    vscCursorLine       = '#242526',   -- editor.lineHighlightBackground
    vscLineNumber       = '#858889',   -- editorLineNumber.foreground
    vscActiveLineNumber = '#BBBEBF',   -- editorLineNumber.activeForeground

    -- =====================================================================
    -- Git Decoration（サインカラム・ファイルツリー）
    -- =====================================================================
    vscGitAdded         = '#72C892',   -- editorGutter.addedBackground（sign col fg）
    vscGitDeleted       = '#F28772',   -- editorGutter.deletedBackground（sign col fg）
    vscGitModified      = '#6ab890',   -- editorOverviewRuler.modifiedForeground
    vscGitAddedDecor    = '#73c991',   -- gitDecoration.addedResourceForeground
    vscGitModDecor      = '#e5ba7d',   -- gitDecoration.modifiedResourceForeground
    vscGitDelDecor      = '#f48771',   -- gitDecoration.deletedResourceForeground

    -- =====================================================================
    -- 診断 / エラー / 警告
    -- =====================================================================
    vscRed              = '#f48771',   -- errorForeground / DiagnosticError
    vscOrangeLight      = '#ffa198',   -- invalid.* / markup.deleted fg
    vscYellow           = '#e5ba7d',   -- DiagnosticWarn / list.warningForeground
    vscInfoBlue         = '#3a94bc',   -- notificationsInfoIcon.foreground

    -- =====================================================================
    -- 構文ハイライト（tokenColors 由来: 2026-dark.json 実使用色のみ）
    -- =====================================================================
    vscComment          = '#8b949e',   -- comment / punctuation.definition.comment
    vscKeyword          = '#ff7b72',   -- keyword / storage / punctuation.section.embedded
    vscString           = '#a5d6ff',   -- string / source.regexp
    vscFunction         = '#d2a8ff',   -- entity.name.function / meta.diff.range
    vscConstant         = '#79c0ff',   -- constant / support / variable.language / meta.property-name
    vscVariable         = '#ffa657',   -- variable / entity.name
    vscTag              = '#7ee787',   -- entity.name.tag / markup.quote / regex escape
    vscParameterFront   = '#c9d1d9',   -- variable.parameter.function / variable.other

    -- 特殊トークン色（2026-dark の token.* スコープ）
    vscInfoToken        = '#6796E6',   -- token.info-token（将来の TokenInfoMsg 等用）
    vscWarnToken        = '#CD9731',   -- token.warn-token（将来の TokenWarnMsg 等用）
    vscErrorToken       = '#F44747',   -- token.error-token（将来の TokenErrorMsg 等用）
    vscDebugToken       = '#B267E6',   -- token.debug-token（DiagnosticHint で使用中）

    -- 特殊背景色（carriage-return / markup.ignored）
    vscCrFg             = '#f0f6fc',   -- carriage-return fg（将来の専用ハイライトグループ定義用）
    vscCrBg             = '#8b1111',   -- carriage-return bg（DiagnosticError 背景等の特殊演出用。現在は VirtualText 非適用）
    vscIgnoredFg        = '#0d1117',   -- markup.ignored fg（将来の専用ハイライトグループ定義用）
    -- markup.ignored bg は vscConstant (#79c0ff) を使用

    -- =====================================================================
    -- ステータスバー
    -- =====================================================================
    vscStatusBack       = '#191A1B',   -- statusBar.background
    vscStatusFront      = '#8C8C8C',   -- statusBar.foreground

    -- =====================================================================
    -- タブ
    -- =====================================================================
    vscTabActiveBack    = '#121314',   -- tab.activeBackground
    vscTabActiveFront   = '#bfbfbf',   -- tab.activeForeground
    vscTabInactiveBack  = '#191A1B',   -- tab.inactiveBackground
    vscTabInactiveFront = '#8C8C8C',   -- tab.inactiveForeground
    vscTabFillBack      = '#191A1B',   -- editorGroupHeader.tabsBackground (TabLineFill)

    -- =====================================================================
    -- Pmenu / 補完
    -- =====================================================================
    vscPmenuBack        = '#202122',   -- editorSuggestWidget.background
    vscPmenuFront       = '#bfbfbf',   -- editorSuggestWidget.foreground
    vscPmenuSelFront    = '#ededed',   -- list.activeSelectionForeground

    -- =====================================================================
    -- ウィンドウ / フロート
    -- =====================================================================
    vscFloatBack        = '#202122',   -- editorWidget.background
    vscFloatBorder      = '#2A2B2C',   -- editorWidget.border (2A2B2CFF)
    vscWinSep           = '#2A2B2C',   -- panel.border（WinSeparator 推奨値）

    -- =====================================================================
    -- ターミナル
    -- =====================================================================
    vscTerminalBack     = '#191A1B',   -- terminal.background
    -- v2: terminal.foreground は #CCCCCC（論点2(A)。dark_modern の値）
    vscTerminalFront    = '#CCCCCC',   -- terminal.foreground
  }

  -- light テーマ受け口（将来拡張用。現在は dark のみ）
  -- light 実装時は: local light = {...} を定義し、右辺を `dark or light` に変更する
  local c = (vim.o.background == 'dark') and dark or dark

  local config = require('codedark26.config')
  return vim.tbl_extend('force', c, config.opts.color_overrides or {})
end

return M
