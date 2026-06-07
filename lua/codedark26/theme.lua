-- lua/codedark26/theme.lua
-- 全ハイライトグループ一括定義
-- v2 寄せ先マトリクス厳守:
--   型・クラス・enum・namespace・数値 → vscConstant (#79c0ff)
--   制御フロー・例外・include・define → vscKeyword (#ff7b72)
--   escape → vscTag (#7ee787)
--   operator・label → vscParameterFront (#c9d1d9)
--   property/attribute/constructor/enumMember → vscConstant (#79c0ff)

local M = {}

function M.set_highlights()
  local colors = require('codedark26.colors')
  local config  = require('codedark26.config')
  local c = colors.get_colors()
  local hl = vim.api.nvim_set_hl

  -- ======================================================================
  -- UI 標準グループ
  -- ======================================================================

  hl(0, 'Normal',        { fg = c.vscFront,        bg = c.vscBack })
  hl(0, 'NormalNC',      { fg = c.vscFront,        bg = c.vscPanelBack })
  hl(0, 'NormalFloat',   { fg = c.vscFront,        bg = c.vscFloatBack })
  hl(0, 'FloatBorder',   { fg = c.vscFloatBorder,  bg = c.vscFloatBack })

  -- コメント
  hl(0, 'Comment',       { fg = c.vscComment,      italic = config.opts.italic_comments })

  -- 行番号
  hl(0, 'LineNr',        { fg = c.vscLineNumber })
  hl(0, 'CursorLineNr',  { fg = c.vscActiveLineNumber })

  -- カーソル行・列
  hl(0, 'CursorLine',    { bg = c.vscCursorLine })
  hl(0, 'CursorColumn',  { bg = c.vscCursorLine })
  hl(0, 'ColorColumn',   { bg = c.vscCursorLine })

  -- 選択（Visual）
  -- editor.selectionBackground #276782dd → bg='#276782', blend=13
  hl(0, 'Visual',        { bg = c.vscSelection,    blend = 13 })
  -- editor.inactiveSelectionBackground #27678260 → blend=62
  hl(0, 'VisualNOS',     { bg = c.vscSelection,    blend = 62 })

  -- 検索ハイライト
  -- editor.findMatchBackground #27678290 → blend=44
  hl(0, 'Search',        { bg = c.vscSelection,    blend = 44 })
  -- editor.findMatchHighlightBackground #27678280 → blend=50
  hl(0, 'IncSearch',     { bg = c.vscSelection,    fg = c.vscFront, blend = 50 })
  hl(0, 'CurSearch',     { link = 'IncSearch' })

  -- ブラケットマッチ
  -- editorBracketMatch.background #3994BC55 → blend=67
  hl(0, 'MatchParen',    { bg = c.vscBracketMatch, blend = 67 })

  -- 非表示文字
  hl(0, 'Whitespace',    { fg = c.vscGray })
  hl(0, 'NonText',       { fg = c.vscGray })

  -- サインカラム
  hl(0, 'SignColumn',    { fg = c.vscGray,          bg = c.vscBack })

  -- ウィンドウ区切り
  hl(0, 'WinSeparator',  { fg = c.vscWinSep })
  hl(0, 'VertSplit',     { fg = c.vscWinSep })

  -- Pmenu（補完メニュー）
  hl(0, 'Pmenu',         { fg = c.vscPmenuFront,   bg = c.vscPmenuBack })
  -- list.activeSelectionBackground #3994BC26 → blend=85
  hl(0, 'PmenuSel',      { fg = c.vscPmenuSelFront, bg = c.vscListActive, blend = 85 })
  hl(0, 'PmenuSbar',     { bg = c.vscPanelBack })
  hl(0, 'PmenuThumb',    { bg = c.vscGray })

  -- ステータスライン
  hl(0, 'StatusLine',    { fg = c.vscStatusFront,  bg = c.vscStatusBack })
  hl(0, 'StatusLineNC',  { fg = c.vscGray,         bg = c.vscPanelBack })

  -- タブライン
  hl(0, 'TabLine',       { fg = c.vscTabInactiveFront, bg = c.vscTabInactiveBack })
  hl(0, 'TabLineSel',    { fg = c.vscTabActiveFront,   bg = c.vscTabActiveBack })
  hl(0, 'TabLineFill',   { bg = c.vscTabFillBack })

  -- ウィンドウバー（winbar）
  hl(0, 'WinBar',        { fg = c.vscGray,         bg = c.vscBack })
  hl(0, 'WinBarNC',      { fg = c.vscGray,         bg = c.vscPanelBack })

  -- カーソル
  hl(0, 'Cursor',        { fg = c.vscBack,         bg = c.vscFront })

  -- タイトル・ディレクトリ
  hl(0, 'Title',         { fg = c.vscConstant,     bold = true })
  hl(0, 'Directory',     { fg = c.vscAccentLighter })

  -- メッセージ系
  hl(0, 'ErrorMsg',      { fg = c.vscRed })
  hl(0, 'WarningMsg',    { fg = c.vscYellow })
  hl(0, 'ModeMsg',       { fg = c.vscFront,        bold = true })
  hl(0, 'MoreMsg',       { fg = c.vscAccentLighter })
  hl(0, 'Question',      { fg = c.vscAccentLighter })

  -- 折りたたみ
  hl(0, 'Folded',        { fg = c.vscComment,      bg = c.vscPanelBack })
  hl(0, 'FoldColumn',    { fg = c.vscComment,      bg = c.vscBack })

  -- ======================================================================
  -- Syntax 標準グループ【v2 で色変更あり】
  -- ======================================================================

  -- 定数・文字列
  hl(0, 'Constant',      { fg = c.vscConstant })
  hl(0, 'String',        { fg = c.vscString })
  hl(0, 'Character',     { fg = c.vscString })
  -- v2: 数値 → constant 青（dark_vs 補完色を排除）
  hl(0, 'Number',        { fg = c.vscConstant })
  hl(0, 'Boolean',       { fg = c.vscConstant })
  hl(0, 'Float',         { fg = c.vscConstant })

  -- 識別子・関数
  hl(0, 'Identifier',    { fg = c.vscVariable })
  hl(0, 'Function',      { fg = c.vscFunction })

  -- 文・キーワード
  hl(0, 'Statement',     { fg = c.vscKeyword })
  -- v2: Conditional/Repeat/Exception → keyword 赤（dark_plus 補完色を排除）
  hl(0, 'Conditional',   { fg = c.vscKeyword })
  hl(0, 'Repeat',        { fg = c.vscKeyword })
  hl(0, 'Exception',     { fg = c.vscKeyword })
  -- v2: Label → 前景レベル（dark_plus 補完色を排除）
  hl(0, 'Label',         { fg = c.vscParameterFront })
  -- v2: Operator → 前景レベル（dark_vs 補完色を排除）
  hl(0, 'Operator',      { fg = c.vscParameterFront })
  hl(0, 'Keyword',       { fg = c.vscKeyword })

  -- プリプロセッサ
  -- v2: PreProc/Include/Define/Macro/PreCondit → keyword 赤（dark_vs 補完色を排除）
  hl(0, 'PreProc',       { fg = c.vscKeyword })
  hl(0, 'Include',       { fg = c.vscKeyword })
  hl(0, 'Define',        { fg = c.vscKeyword })
  hl(0, 'Macro',         { fg = c.vscKeyword })
  hl(0, 'PreCondit',     { fg = c.vscKeyword })

  -- 型
  -- v2: Type/StorageClass/Structure/Typedef → constant 青（dark_plus 補完色を排除）
  hl(0, 'Type',          { fg = c.vscConstant })
  hl(0, 'StorageClass',  { fg = c.vscConstant })
  hl(0, 'Structure',     { fg = c.vscConstant })
  hl(0, 'Typedef',       { fg = c.vscConstant })

  -- 特殊
  hl(0, 'Special',       { fg = c.vscConstant })
  -- v2: SpecialChar（escape） → tag 緑（dark_plus 補完色を排除）
  hl(0, 'SpecialChar',   { fg = c.vscTag })
  hl(0, 'Tag',           { fg = c.vscTag })
  hl(0, 'Delimiter',     { fg = c.vscComment })
  hl(0, 'SpecialComment',{ fg = c.vscComment,  bold = true })
  hl(0, 'Debug',         { fg = c.vscOrangeLight })
  hl(0, 'Underlined',    { fg = c.vscAccentLighter, underline = true })
  hl(0, 'Error',         { fg = c.vscOrangeLight })
  hl(0, 'Todo',          { fg = c.vscFront,    bg = c.vscComment,   bold = true })

  -- ======================================================================
  -- Treesitter (@xxx)【v2 で色変更あり】
  -- ======================================================================

  -- コメント
  hl(0, '@comment',                  { link = 'Comment' })
  hl(0, '@comment.documentation',    { fg = c.vscComment,   italic = config.opts.italic_comments })

  -- 定数
  hl(0, '@constant',                 { link = 'Constant' })
  hl(0, '@constant.builtin',         { fg = c.vscConstant })
  hl(0, '@constant.macro',           { fg = c.vscKeyword })

  -- 文字列
  hl(0, '@string',                   { link = 'String' })
  hl(0, '@string.special',           { fg = c.vscConstant })
  -- v2: escape → tag 緑（dark_plus 補完色を排除）
  hl(0, '@string.escape',            { fg = c.vscTag })
  -- regex 本体 → string 青系（2026-dark の source.regexp 先例）
  hl(0, '@string.regex',             { fg = c.vscString })

  -- 関数
  hl(0, '@function',                 { link = 'Function' })
  hl(0, '@function.call',            { link = 'Function' })
  hl(0, '@function.builtin',         { fg = c.vscFunction })
  hl(0, '@method',                   { link = 'Function' })
  hl(0, '@method.call',              { link = 'Function' })

  -- 変数
  hl(0, '@variable',                 { fg = c.vscVariable })
  hl(0, '@variable.parameter',       { fg = c.vscParameterFront })
  hl(0, '@variable.builtin',         { fg = c.vscConstant })

  -- キーワード
  hl(0, '@keyword',                  { link = 'Keyword' })
  hl(0, '@keyword.storage',          { fg = c.vscKeyword })
  -- v2: conditional/exception/repeat → keyword 赤（dark_plus 補完色を排除）
  hl(0, '@keyword.conditional',      { fg = c.vscKeyword })
  hl(0, '@keyword.exception',        { fg = c.vscKeyword })
  hl(0, '@keyword.repeat',           { fg = c.vscKeyword })
  -- v2: import/directive → keyword 赤（2026-dark の storage/storage.type 先例）
  hl(0, '@keyword.import',           { fg = c.vscKeyword })
  hl(0, '@keyword.directive',        { fg = c.vscKeyword })
  -- v2: unit (CSS px/em等) → constant 青（Number 同様に constant 帯）
  hl(0, '@keyword.unit',             { fg = c.vscConstant })

  -- 型
  -- v2: @type/@type.builtin → constant 青（dark_plus 補完色を排除）
  hl(0, '@type',                     { fg = c.vscConstant })
  hl(0, '@type.builtin',             { fg = c.vscConstant })

  -- 名前空間・モジュール
  -- v2: @namespace/@module → constant 青（2026-dark の meta.module-reference 先例）
  hl(0, '@namespace',                { fg = c.vscConstant })
  hl(0, '@module',                   { fg = c.vscConstant })

  -- プロパティ・属性
  -- v2: @property → constant 青（2026-dark の meta.property-name 先例）
  hl(0, '@property',                 { fg = c.vscConstant })
  hl(0, '@field',                    { fg = c.vscConstant })
  -- v2: @attribute → constant 青（dark_vs 補完色を排除）
  hl(0, '@attribute',                { fg = c.vscConstant })

  -- タグ（HTML/JSX）
  hl(0, '@tag',                      { fg = c.vscTag })
  hl(0, '@tag.builtin',              { fg = c.vscTag })
  hl(0, '@tag.attribute',            { fg = c.vscVariable })
  hl(0, '@tag.delimiter',            { fg = c.vscTag })

  -- 数値
  -- v2: @number/@float → constant 青（dark_vs 補完色を排除）
  hl(0, '@number',                   { fg = c.vscConstant })
  hl(0, '@float',                    { fg = c.vscConstant })

  -- 演算子・ラベル
  -- v2: @operator → 前景レベル（dark_vs 補完色を排除）
  hl(0, '@operator',                 { fg = c.vscParameterFront })
  -- v2: @label → 前景レベル（dark_plus 補完色を排除）
  hl(0, '@label',                    { fg = c.vscParameterFront })

  -- v2: @constructor → constant 青（型扱いに統一）
  hl(0, '@constructor',              { fg = c.vscConstant })

  -- 句読点
  hl(0, '@punctuation.bracket',      { fg = c.vscComment })
  -- punctuation.section.embedded → keyword 赤（2026-dark 先例）
  hl(0, '@punctuation.special',      { fg = c.vscKeyword })
  hl(0, '@punctuation.delimiter',    { fg = c.vscParameterFront })

  -- マークアップ
  hl(0, '@markup.heading',           { fg = c.vscConstant,  bold = true })
  hl(0, '@markup.strong',            { fg = c.vscParameterFront, bold = true })
  hl(0, '@markup.italic',            { fg = c.vscParameterFront, italic = true })
  hl(0, '@markup.underline',         { underline = true })
  hl(0, '@markup.strikethrough',     { strikethrough = true })
  hl(0, '@markup.quote',             { fg = c.vscTag })
  hl(0, '@markup.raw',               { fg = c.vscConstant })
  hl(0, '@markup.link',              { fg = c.vscAccentLighter, underline = config.opts.underline_links })
  hl(0, '@markup.link.url',          { fg = c.vscString,    underline = config.opts.underline_links })

  -- Diff
  hl(0, '@diff.plus',                { fg = c.vscGitAddedDecor })
  hl(0, '@diff.minus',               { fg = c.vscOrangeLight })
  hl(0, '@diff.delta',               { fg = c.vscVariable })

  -- エラー
  hl(0, '@error',                    { fg = c.vscOrangeLight })

  -- ======================================================================
  -- LSP semantic (@lsp.*)【v2 で大きく変更】
  -- ======================================================================

  -- v2: string → String (#a5d6ff)（dark_plus 補完色を排除）
  hl(0, '@lsp.type.string',          { link = 'String' })
  -- v2: number → Constant (#79c0ff)（dark_plus 補完色を排除）
  hl(0, '@lsp.type.number',          { link = 'Constant' })
  -- v2: operator (new/delete/typeof等キーワード演算子) → Keyword (#ff7b72)
  --     （dark_plus newOperator 補完色を排除）
  hl(0, '@lsp.type.operator',        { link = 'Keyword' })
  -- 関数・メソッド
  hl(0, '@lsp.type.function',        { link = 'Function' })
  hl(0, '@lsp.type.method',          { link = 'Function' })
  -- キーワード
  hl(0, '@lsp.type.keyword',         { link = 'Keyword' })
  -- v2: 型系 → Type (#79c0ff)（dark_plus 補完色を排除）
  hl(0, '@lsp.type.type',            { link = 'Type' })
  hl(0, '@lsp.type.class',           { link = 'Type' })
  hl(0, '@lsp.type.enum',            { link = 'Type' })
  hl(0, '@lsp.type.interface',       { link = 'Type' })
  hl(0, '@lsp.type.struct',          { link = 'Type' })
  -- v2: enumMember → Constant (#79c0ff)（dark_plus 補完色を排除）
  hl(0, '@lsp.type.enumMember',      { link = 'Constant' })
  -- 変数・パラメータ
  hl(0, '@lsp.type.variable',        { link = '@variable' })
  hl(0, '@lsp.type.parameter',       { fg = c.vscParameterFront })
  -- v2: property → @property (#79c0ff)（dark_vs 補完色を排除）
  hl(0, '@lsp.type.property',        { link = '@property' })
  -- v2: namespace → @namespace (#79c0ff)（dark_plus 補完色を排除）
  hl(0, '@lsp.type.namespace',       { link = '@namespace' })
  hl(0, '@lsp.type.module',          { link = '@module' })
  -- マクロ・修飾子
  hl(0, '@lsp.type.macro',           { link = 'Keyword' })
  hl(0, '@lsp.type.modifier',        { link = 'Keyword' })
  -- イベント → constant 青
  hl(0, '@lsp.type.event',           { link = 'Constant' })
  -- コメント
  hl(0, '@lsp.type.comment',         { link = 'Comment' })
  -- 修飾子
  hl(0, '@lsp.mod.deprecated',       { strikethrough = true })
  hl(0, '@lsp.mod.readonly',         { link = 'Constant' })

  -- ======================================================================
  -- Diagnostic
  -- ======================================================================

  hl(0, 'DiagnosticError',           { fg = c.vscRed })
  hl(0, 'DiagnosticWarn',            { fg = c.vscYellow })
  hl(0, 'DiagnosticInfo',            { fg = c.vscInfoBlue })
  hl(0, 'DiagnosticHint',            { fg = c.vscDebugToken })
  hl(0, 'DiagnosticOk',             { fg = c.vscTag })

  -- VirtualText
  -- carriage-return 背景色 (vscCrBg) は VirtualText には適用しない
  hl(0, 'DiagnosticVirtualTextError', { fg = c.vscRed })
  hl(0, 'DiagnosticVirtualTextWarn',  { fg = c.vscYellow })
  hl(0, 'DiagnosticVirtualTextInfo',  { fg = c.vscInfoBlue })
  hl(0, 'DiagnosticVirtualTextHint',  { fg = c.vscDebugToken })

  -- Underline（undercurl + sp でサポートされる場合）
  hl(0, 'DiagnosticUnderlineError',   { undercurl = true, sp = c.vscRed })
  hl(0, 'DiagnosticUnderlineWarn',    { undercurl = true, sp = c.vscYellow })
  hl(0, 'DiagnosticUnderlineInfo',    { undercurl = true, sp = c.vscInfoBlue })
  hl(0, 'DiagnosticUnderlineHint',    { undercurl = true, sp = c.vscDebugToken })

  -- Sign
  hl(0, 'DiagnosticSignError',        { fg = c.vscRed })
  hl(0, 'DiagnosticSignWarn',         { fg = c.vscYellow })
  hl(0, 'DiagnosticSignInfo',         { fg = c.vscInfoBlue })
  hl(0, 'DiagnosticSignHint',         { fg = c.vscDebugToken })

  -- Floating
  hl(0, 'DiagnosticFloatingError',    { fg = c.vscRed })
  hl(0, 'DiagnosticFloatingWarn',     { fg = c.vscYellow })
  hl(0, 'DiagnosticFloatingInfo',     { fg = c.vscInfoBlue })
  hl(0, 'DiagnosticFloatingHint',     { fg = c.vscDebugToken })

  -- ======================================================================
  -- LSP 基本
  -- ======================================================================

  -- editor.wordHighlightBackground #27678250 → blend=69
  hl(0, 'LspReferenceText',           { bg = c.vscSelection, blend = 69 })
  hl(0, 'LspReferenceRead',           { bg = c.vscSelection, blend = 69 })
  -- editor.wordHighlightStrongBackground #27678280 → blend=50
  hl(0, 'LspReferenceWrite',          { bg = c.vscSelection, blend = 50 })
  hl(0, 'LspInlayHint',               { fg = c.vscGray,    italic = config.opts.italic_inlayhints })
  hl(0, 'LspCodeLens',                { fg = c.vscGray })
  hl(0, 'LspCodeLensOperator',        { fg = c.vscGray })

  -- ======================================================================
  -- Diff / Git 標準
  -- ======================================================================

  -- diffEditor.insertedLineBackground #347d3926 → blend=85
  hl(0, 'DiffAdd',    { bg = c.vscDiffAddLine, blend = 85 })
  -- diffEditor.insertedTextBackground #57ab5a4d → blend=70
  hl(0, 'DiffText',   { bg = c.vscDiffAddText, blend = 70 })
  -- diffEditor.removedLineBackground #c93c3726 → blend=85
  hl(0, 'DiffDelete', { bg = c.vscDiffDelLine, blend = 85 })
  -- diffEditor.removedTextBackground #f470674d → blend=70
  -- 注: blend>50 の混色は実機差あり。違和感があれば bg 事前合成に切替推奨
  hl(0, 'DiffChange', { bg = c.vscDiffDelText, blend = 70 })

  -- ======================================================================
  -- プラグイン統合 top 8
  -- ======================================================================

  -- ------------------------------------------------------------
  -- 1. nvim-cmp
  -- ------------------------------------------------------------
  -- Function/Method/Constructor
  hl(0, 'CmpItemKindFunction',      { link = 'Function' })
  hl(0, 'CmpItemKindMethod',        { link = 'Function' })
  hl(0, 'CmpItemKindConstructor',   { link = 'Function' })
  -- 型系 → v2: constant 青
  hl(0, 'CmpItemKindClass',         { link = 'Type' })
  hl(0, 'CmpItemKindStruct',        { link = 'Type' })
  hl(0, 'CmpItemKindInterface',     { link = 'Type' })
  hl(0, 'CmpItemKindEnum',          { link = 'Type' })
  hl(0, 'CmpItemKindTypeParameter', { link = 'Type' })
  -- 変数・フィールド
  hl(0, 'CmpItemKindVariable',      { fg = c.vscVariable })
  hl(0, 'CmpItemKindField',         { link = '@property' })
  -- キーワード・演算子
  hl(0, 'CmpItemKindKeyword',       { link = 'Keyword' })
  hl(0, 'CmpItemKindOperator',      { link = 'Keyword' })
  -- 定数・enum メンバー・値
  hl(0, 'CmpItemKindConstant',      { link = 'Constant' })
  hl(0, 'CmpItemKindEnumMember',    { link = 'Constant' })
  hl(0, 'CmpItemKindValue',         { link = 'Constant' })
  -- モジュール・参照
  hl(0, 'CmpItemKindModule',        { link = '@module' })
  hl(0, 'CmpItemKindReference',     { link = '@module' })
  -- テキスト系（前景レベル）
  hl(0, 'CmpItemKindText',          { fg = c.vscLightGray })
  hl(0, 'CmpItemKindFile',          { fg = c.vscLightGray })
  hl(0, 'CmpItemKindFolder',        { fg = c.vscLightGray })
  hl(0, 'CmpItemKindSnippet',       { fg = c.vscParameterFront })
  -- 色
  hl(0, 'CmpItemKindColor',         { link = '@string.special' })
  -- マッチハイライト
  hl(0, 'CmpItemAbbrMatch',         { fg = c.vscAccentLighter })
  hl(0, 'CmpItemAbbrMatchFuzzy',    { fg = c.vscAccentLighter })
  hl(0, 'CmpItemAbbrDeprecated',    { strikethrough = true })
  hl(0, 'CmpItemMenu',              { fg = c.vscGray })

  -- ------------------------------------------------------------
  -- 2. nvim-tree
  -- ------------------------------------------------------------
  local nvimtree_bg = config.opts.disable_nvimtree_bg and 'NONE' or c.vscPanelBack
  hl(0, 'NvimTreeNormal',           { fg = c.vscFront,        bg = nvimtree_bg })
  hl(0, 'NvimTreeNormalNC',         { fg = c.vscGray,         bg = nvimtree_bg })
  hl(0, 'NvimTreeFolderName',       { fg = c.vscLightGray })
  hl(0, 'NvimTreeOpenedFolderName', { fg = c.vscFront,        bold = true })
  hl(0, 'NvimTreeEmptyFolderName',  { fg = c.vscGray })
  hl(0, 'NvimTreeRootFolder',       { fg = c.vscAccentLighter, bold = true })
  hl(0, 'NvimTreeSpecialFile',      { fg = c.vscFunction,     underline = true })
  hl(0, 'NvimTreeGitDirty',         { fg = c.vscGitModDecor })
  hl(0, 'NvimTreeGitStaged',        { fg = c.vscGitAddedDecor })
  hl(0, 'NvimTreeGitNew',           { fg = c.vscGitAddedDecor })
  hl(0, 'NvimTreeGitDeleted',       { fg = c.vscGitDelDecor })
  hl(0, 'NvimTreeGitMerge',         { fg = c.vscOrangeLight })
  hl(0, 'NvimTreeGitRenamed',       { fg = c.vscGitModDecor })

  -- ------------------------------------------------------------
  -- 3. neo-tree
  -- ------------------------------------------------------------
  hl(0, 'NeoTreeNormal',            { fg = c.vscFront,        bg = c.vscPanelBack })
  hl(0, 'NeoTreeNormalNC',          { fg = c.vscGray,         bg = c.vscPanelBack })
  hl(0, 'NeoTreeDirectoryName',     { fg = c.vscLightGray })
  hl(0, 'NeoTreeDirectoryIcon',     { fg = c.vscAccentLighter })
  hl(0, 'NeoTreeRootName',          { fg = c.vscAccentLighter, bold = true })
  hl(0, 'NeoTreeGitModified',       { fg = c.vscGitModDecor })
  hl(0, 'NeoTreeGitAdded',          { fg = c.vscGitAddedDecor })
  hl(0, 'NeoTreeGitDeleted',        { fg = c.vscGitDelDecor })
  hl(0, 'NeoTreeDotfile',           { fg = c.vscGray })
  hl(0, 'NeoTreeHidden',            { fg = c.vscMediumGray })
  hl(0, 'NeoTreeFileName',          { fg = c.vscFront })
  hl(0, 'NeoTreeFileNameOpened',    { fg = c.vscFront,        bold = true })

  -- ------------------------------------------------------------
  -- 4. telescope
  -- ------------------------------------------------------------
  hl(0, 'TelescopeBorder',          { fg = c.vscFloatBorder,  bg = c.vscFloatBack })
  hl(0, 'TelescopeMatching',        { fg = c.vscAccentLighter })
  hl(0, 'TelescopeSelection',       { fg = c.vscPmenuSelFront, bg = c.vscListActive, blend = 85 })
  hl(0, 'TelescopeSelectionCaret',  { fg = c.vscAccentLighter })
  hl(0, 'TelescopePromptTitle',     { fg = c.vscFront,        bg = c.vscAccent })
  hl(0, 'TelescopeResultsTitle',    { fg = c.vscFront,        bg = c.vscPanelBack })
  hl(0, 'TelescopePreviewTitle',    { fg = c.vscFront,        bg = c.vscPanelBack })

  -- ------------------------------------------------------------
  -- 5. gitsigns
  -- ------------------------------------------------------------
  hl(0, 'GitSignsAdd',              { fg = c.vscGitAdded })
  hl(0, 'GitSignsChange',           { fg = c.vscGitModified })
  hl(0, 'GitSignsDelete',           { fg = c.vscGitDeleted })
  hl(0, 'GitSignsAddNr',            { fg = c.vscGitAdded })
  hl(0, 'GitSignsChangeNr',         { fg = c.vscGitModified })
  hl(0, 'GitSignsDeleteNr',         { fg = c.vscGitDeleted })
  hl(0, 'GitSignsAddLn',            { bg = c.vscDiffAddLine,  blend = 85 })
  hl(0, 'GitSignsChangeLn',         { bg = c.vscDiffAddText,  blend = 70 })
  hl(0, 'GitSignsDeleteLn',         { bg = c.vscDiffDelLine,  blend = 85 })
  hl(0, 'GitSignsAddCul',           { fg = c.vscGitAdded })
  hl(0, 'GitSignsChangeCul',        { fg = c.vscGitModified })
  hl(0, 'GitSignsDeleteCul',        { fg = c.vscGitDeleted })
  hl(0, 'GitSignsAddInline',        { bg = c.vscDiffAddText,  blend = 70 })
  hl(0, 'GitSignsChangeInline',     { bg = c.vscDiffAddText,  blend = 70 })
  hl(0, 'GitSignsDeleteInline',     { bg = c.vscDiffDelText,  blend = 70 })
  hl(0, 'GitSignsDeletePreview',    { bg = c.vscDiffDelLine,  blend = 85 })
  hl(0, 'GitSignsDeleteVirtLn',     { fg = c.vscOrangeLight })

  -- ------------------------------------------------------------
  -- 6. indent-blankline (ibl)
  -- ------------------------------------------------------------
  -- editorIndentGuide.background #8384854D → ソリッド代用
  hl(0, 'IblIndent',                { fg = c.vscIndentGuide })
  -- editorIndentGuide.activeBackground #838485
  hl(0, 'IblScope',                 { fg = c.vscGray })

  -- ------------------------------------------------------------
  -- 7. bufferline
  -- ------------------------------------------------------------
  hl(0, 'BufferLineFill',           { bg = c.vscTabFillBack })
  hl(0, 'BufferLineBackground',     { fg = c.vscTabInactiveFront, bg = c.vscTabInactiveBack })
  hl(0, 'BufferLineBufferSelected', { fg = c.vscTabActiveFront,   bg = c.vscTabActiveBack, bold = true })
  hl(0, 'BufferLineSeparator',      { fg = c.vscBorder,           bg = c.vscTabInactiveBack })
  hl(0, 'BufferLineModified',       { fg = c.vscGitModDecor,      bg = c.vscTabInactiveBack })
  hl(0, 'BufferLineModifiedSelected', { fg = c.vscGitModDecor,    bg = c.vscTabActiveBack })
  hl(0, 'BufferLineIndicatorSelected', { fg = c.vscAccentLight,   bg = c.vscTabActiveBack })

  -- ------------------------------------------------------------
  -- 8. which-key
  -- ------------------------------------------------------------
  hl(0, 'WhichKey',                 { fg = c.vscKeyword })
  hl(0, 'WhichKeyGroup',            { fg = c.vscConstant })
  hl(0, 'WhichKeyDesc',             { fg = c.vscParameterFront })
  hl(0, 'WhichKeyFloat',            { bg = c.vscFloatBack })
  hl(0, 'WhichKeySeparator',        { fg = c.vscComment })

  -- ======================================================================
  -- User group overrides（末尾に適用）
  -- ======================================================================
  for group, opts in pairs(config.opts.group_overrides or {}) do
    hl(0, group, opts)
  end
end

return M
