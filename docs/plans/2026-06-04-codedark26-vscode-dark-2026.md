# codedark26 — VS Code Dark 2026 を Neovim カラースキームに移植 実装記録

_作成: 2026-06-04 | ステータス: 進行中_

## 目標

VS Code が 2026 年に導入した新デフォルトテーマ「**VS Code Dark 2026**」（`2026-dark.json`、コンセプト名「Focus」）を、Neovim 専用カラースキームプラグイン **`codedark26`** として新規移植する。`Mofiqul/vscode.nvim` 流の Lua モダン構成を採用し、フルスコープ（標準ハイライト + Treesitter + LSP semantic + Diagnostic + terminal colors + lualine + 主要プラグイン top8）で実装する。

### ユーザー確定方針

| 論点 | 決定 |
|---|---|
| 対象テーマ | VS Code Dark 2026 のみ（Light は対象外。将来余地のみ） |
| 実装土台 | Lua モダン構成（`colors/codedark26.vim` エントリ + `lua/codedark26/{init,colors,theme,config,utils}.lua`） |
| スコープ | フル（プラグイン統合 top8 まで） |
| 構文色（論点1） | **(B) 2026-dark に忠実＝dark_plus/dark_vs 由来の補完色を一切持ち込まない**（Focus 統一感最優先） |
| terminal前景（論点2） | **(A) `#CCCCCC`**（VS Code 標準値） |

## 実装計画

### フェーズ A: 基盤・パレット
- [ ] ステップ1: `lua/codedark26/config.lua`（setup オプション・デフォルト値）
- [ ] ステップ2: `lua/codedark26/colors.lua`（v2 実使用色の母集合のみ。補完色は定義しない）
- [ ] ステップ3: `lua/codedark26/theme.lua`（全ハイライト一括定義・最大ボリューム）
- [ ] ステップ4: `lua/codedark26/utils.lua`（terminal colors 0-15）
- [ ] ステップ5: `lua/codedark26/init.lua`（load/setup エントリ）
- [ ] ステップ6: `colors/codedark26.vim`（`:colorscheme` エントリポイント）

### フェーズ B: 統合・補助
- [ ] ステップ7: `lua/lualine/themes/codedark26.lua`（mode 別テーマ）
- [ ] ステップ8: `README.md` / `LICENSE`（Focus 統一方針の明記を含む）
- [ ] ステップ9: `after/queries/{javascript,typescript}/highlights.scm`（任意・推奨）

---

## 設計詳細

> 色の最終正値は **生 JSON (`vscode-theme-json/2026-dark.json` + 継承元) を SSOT**。詳細フル版プランは RUN_DIR の `plan.md` を参照（`~/.ai-pir-runs/-home-coil398-ghq-github-com-coil398-codedark-26/20260604-003406-codedark-neovim-vscode-new-theme/plan.md`）。

### v2 寄せ先マトリクス（補完色を排除し 2026-dark 実使用色に寄せる）

| Vim / Treesitter / LSP グループ | 概念 | 寄せ先色 |
|---|---|---|
| `Type` / `@type` / `@type.builtin` / `@namespace` / `@lsp.type.{type,class,enum,interface,struct}` | 型・クラス・enum型・namespace | `#79c0ff` constant青 |
| `Number` / `Float` / `@number` / `@float` / `@lsp.type.number` | 数値リテラル | `#79c0ff` constant青 |
| `Conditional` / `Repeat` / `Exception` / `Include` / `Define` / `Macro` / `PreProc` / `@keyword.{conditional,exception,repeat,import,directive}` / `@lsp.type.operator` | 制御フロー・例外・include・キーワード演算子(new等) | `#ff7b72` keyword赤 |
| `Operator` / `@operator` / `Label` / `@label` / `@punctuation.delimiter` / `@lsp.type.parameter` | 記号演算子・ラベル・区切り（色を付けない＝Focus統一） | `#c9d1d9` 前景 |
| `SpecialChar` / `@string.escape` | 文字列内エスケープ | `#7ee787` tag緑 |
| `@property` / `@attribute` / `@constructor` / `@lsp.type.{property,enumMember,event}` | プロパティ・属性・コンストラクタ・enumメンバー | `#79c0ff` constant青 |
| `@string.regex` / `@lsp.type.string` | 正規表現・LSP文字列 | `#a5d6ff` string青系 |
| JSON 専用 property | `support.type.property-name.json` 先例 | `#7ee787` tag緑 |

> 結果として型・数値・プロパティ等が全て constant 青に統合され、色数が VS Code 2026 同様に少なく感じる。これは Focus 統一の意図した帰結（ユーザー方針）。

### v2 実使用色の母集合（colors.lua に定義する色）

**構文系**: `#8b949e`(comment) / `#ff7b72`(keyword) / `#79c0ff`(constant/support/型/数値/property) / `#ffa657`(variable/entity.name) / `#c9d1d9`(parameter前景/operator/label) / `#d2a8ff`(function) / `#7ee787`(tag/escape) / `#ffa198`(invalid) / `#a5d6ff`(string/regex) ほか token.* (`#6796E6`/`#CD9731`/`#F44747`/`#B267E6`)

**UI/背景**: editor.bg `#121314` / panel.bg `#191A1B` / 前景 `#bfbfbf`,`#BBBEBF` / secondary `#8C8C8C` / 各種背景 `#202122`〜`#2A2B2C` ほか
**Git**: `#73c991`,`#e5ba7d`,`#f48771`,`#72C892`,`#F28772`
**アクセント**: `#297AA0`,`#3994BC`,`#48A0C7`,`#53A5CA`,`#3a94bc`
**terminal前景(v2追加)**: `vscTerminalFront = #CCCCCC`

> ⚠️ 補完色 `#4EC9B0` / `#C586C0` / `#b5cea8` / `#d7ba7d` / `#9CDCFE` / `#C8C8C8` / `#d4d4d4` / `#ce9178` / `#4FC1FF` / `#569cd6` / `#DCDCAA` は **colors.lua / theme.lua に一切書かない**（grep で 0 件確認が機械ゲート）。

### config デフォルト値

`style='dark'` / `transparent=false` / `italic_comments=false`（2026-dark の comment に fontStyle なし）/ `italic_inlayhints=false` / `underline_links=false` / `disable_nvimtree_bg=false` / `terminal_colors=true` / `color_overrides={}` / `group_overrides={}`

### terminal colors 16色マッピング（v2）

0=`#191A1B` 1=`#f48771` 2=`#7ee787` 3=`#e5ba7d` 4=`#79c0ff` 5=`#d2a8ff` 6=`#48A0C7` 7=`#bfbfbf` / 8=`#8C8C8C` 9=`#ffa198` 10=`#73c991` 11=`#ffa657` 12=`#3994BC` 13=**`#d2a8ff`**(v2: function紫。補完色 `#C586C0` を排除) 14=`#53A5CA` 15=`#ededed`
> index 5 と 13 が同色になるのは Focus パレットに紫系が `#d2a8ff` 一色しかないための論理的帰結（許容）。

### アルファ付き hex(8桁) の方針

`nvim_set_hl` の fg/bg はアルファ非対応。bg は `#RRGGBB`+`blend=round((1-AA/255)*100)` をインライン指定（例: Visual ← `#276782dd` → `bg='#276782', blend=13`）。fg はソリッド代用。Diff 系 blend>50 は実機差ありうるためコメントで注記。

### テスト・検証

- 自動テストフレームワークは導入しない（カラースキームの慣習）。
- implementer 自己検証: 全 `.lua` の構文チェック（`luac -p` / `luacheck`）+ 補完色 grep 0 件確認。
- tester: headless Neovim で `:colorscheme codedark26` ロード成功 + `Type`=`#79c0ff` / `Number`=`#79c0ff` / `Conditional`=`#ff7b72` の機械検証 + lualine テーマロード検証。

---

## 実装ログ

### 実装完了

**作成ファイル（11件・全て新規）**: `lua/codedark26/{config,colors,theme,utils,init}.lua` / `colors/codedark26.vim` / `lua/lualine/themes/codedark26.lua` / `README.md` / `LICENSE` / `after/queries/{javascript,typescript}/highlights.scm`

**ループ実績**: INNER_LOOP_COUNT=1（reviewer 01 FAIL[StorageClass]→IMPL02 修正→reviewer 02 全PASS）/ refactor 8件 all 適用→reviewer 03 全PASS / tester PASS（OUTER_LOOP_COUNT=0）

#### `colors/codedark26.vim`（エントリポイント）
- 何を: `:colorscheme codedark26` 実行時に Lua をロードするだけの 1 行エントリ。
- 主要なコード: `lua require('codedark26').load()`
- なぜ: vscode.nvim 慣習（`colors/<name>.vim` がコマンド名=ファイル名）に準拠。VimScript はこの橋渡しのみで、実体は Lua。

#### `lua/codedark26/init.lua`（公開 API）
- 何を: `setup`（config へ委譲）と `load(style)` を公開。`load` は `hi clear`→`syntax reset`→`termguicolors=true`→`colors_name='codedark26'`→`theme.set_highlights()`→（`terminal_colors` true 時）`utils.set_terminal_colors()`。
- 主要なコード: `if style then vim.o.background = (style == 'light') and 'light' or 'dark' end`
- なぜ: `style` 引数は将来 light 追加の受け口だけ残す最小実装（ユーザー方針: light は今は非実装）。

#### `lua/codedark26/colors.lua`（パレット母集合）
- 何を: `get_colors()` が **2026-dark.json 実使用色のみ**のテーブルを返す。dark_plus/dark_vs 由来の補完色は一切定義しない（Focus 統一）。アルファ付き色はベース `#RRGGBB` のみ保存し blend は theme.lua 側でインライン指定。末尾で `color_overrides` をマージ。
- 主要なコード:
  ```lua
  vscConstant = '#79c0ff',  -- constant / support / 型・数値・property の寄せ先
  vscKeyword  = '#ff7b72',  -- keyword / storage / 制御フローの寄せ先
  vscSelection = '#276782', -- editor.selectionBackground ベース (dd=87% → blend=13)
  local c = (vim.o.background == 'dark') and dark or dark  -- light 受け口の骨組み
  return vim.tbl_extend('force', c, config.opts.color_overrides or {})
  ```
- なぜ: ユーザー方針（論点1=B）で補完色を排除。型/数値/property を `vscConstant` 青、制御フローを `vscKeyword` 赤に集約することで VS Code Dark 2026 の削減パレットを忠実再現。

#### `lua/codedark26/theme.lua`（全ハイライト・最大ボリューム）
- 何を: `set_highlights()` で UI/Syntax/Treesitter(@xxx)/LSP(@lsp.*)/Diagnostic/Diff/プラグイン top8 を `vim.api.nvim_set_hl` で一括定義。冒頭コメントに v2 寄せ先マトリクスを明記。末尾で `group_overrides` をループ適用。
- 主要なコード:
  ```lua
  local hl = vim.api.nvim_set_hl
  hl(0, 'Normal',  { fg = c.vscFront, bg = c.vscBack })
  hl(0, 'Visual',  { bg = c.vscSelection, blend = 13 })  -- #276782dd のアルファを blend で表現
  hl(0, 'StorageClass', { fg = c.vscConstant })           -- v2: 型系=青（reviewer FAIL を IMPL02 で修正）
  ```
- なぜ: アルファ非対応の `nvim_set_hl` で VS Code の半透明選択色を再現するため `blend` をインライン指定。`StorageClass` は plan L258 の型系分類に従い `vscConstant`（当初 keyword 赤で実装し reviewer FAIL→修正）。

#### `lua/codedark26/config.lua`（setup オプション）
- 何を: デフォルト（`transparent=false` / `italic_comments=false` / `terminal_colors=true` 等）。`setup()` で `vim.tbl_extend('force', ...)` マージ、`transparent=true` 時は `color_overrides.vscBack='NONE'` を強制。末尾で `M.setup()` 初期化。
- なぜ: `italic_comments=false` は 2026-dark の comment tokenColor に fontStyle 指定がないため忠実再現。

#### `lua/codedark26/utils.lua`（terminal 16色）
- 何を: `set_terminal_colors()` が `vim.g.terminal_color_0..15` を設定。生 JSON に ANSI 定義がないため Focus パレットから自前マッピング。補完色 `#C586C0` は使わず index 13(br magenta) は `#d2a8ff`（index 5 と同色を許容）。terminal.fg は `#CCCCCC`（論点2=A）。
- 主要なコード（refactor 提案6 適用後）:
  ```lua
  local colors = require('codedark26.colors')  -- 関数内 require（循環依存なし）
  local c = colors.get_colors()
  vim.g.terminal_color_4 = c.vscConstant        -- '#79c0ff'（変数参照化）
  vim.g.terminal_color_6 = '#48A0C7'            -- UI色由来は hex 維持（1:1対応せず）
  ```
- なぜ: refactor 提案6 で colors.lua の vsc 変数に 1:1 対応する index だけ変数参照化し、パレット変更時の同期漏れを防止。UI色由来（textLink/accent）の index は hex 維持。

#### `lua/lualine/themes/codedark26.lua`（lualine テーマ）
- 何を: mode 別 a/b/c。normal=`vscAccent`、insert=`vscGitAddedDecor`、visual=`vscFunction`、replace=`vscRed`、command=`vscYellow`。`transparent` で c セクション bg を NONE。
- なぜ: runtimepath 規約上 `lua/lualine/themes/<name>.lua` 固定位置。VS Code のモード非依存配色に対し Neovim 慣習のモード別アクセントを採用。

#### `README.md` / `LICENSE` / `after/queries/{js,ts}/highlights.scm`
- README: インストール手順（lazy/packer/vim-plug）、setup オプション表、**Focus 統一方針（補完色を持ち込まず型/数値=青・制御=赤に統一する設計判断）を明記**、lualine は setup() を先に呼ぶ注記（refactor 提案4）。LICENSE: MIT（coil398, 2026）。scm: `export`→`@keyword.import` 等の Treesitter オーバーライド（`@type` は v2 で青になる注記付き）。

---

> このドキュメントは内容を確認後に削除してください。
> `rm docs/plans/2026-06-04-codedark26-vscode-dark-2026.md`
