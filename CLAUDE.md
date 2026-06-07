# codedark26 開発ガイド

VS Code Dark 2026 (Focus) を Neovim カラースキームとして移植したプラグイン。ユーザー向けの設計方針・使い方は `README.md` を参照。本ファイルは**コードや README から自明に読み取れない開発時の罠**を記録する。

## 色の割り当てルール（編集時に必ず守る）

### Focus 統一パレット — 補完色を足さない

`2026-dark.json` の**実使用色のみ**を採用する設計。`dark_plus` / `dark_vs` 由来の補完色は **`colors.lua` / `theme.lua` に一切定義しない**（コメント内に hex を書くのも禁止）。排除対象の 11 色:

```
#4EC9B0 #C586C0 #b5cea8 #d7ba7d #9CDCFE #C8C8C8 #d4d4d4 #ce9178 #4FC1FF #569cd6 #DCDCAA
```

編集後は以下の grep ゲートで **0 件**を確認する（コメント行も対象になるため、説明文中にも補完色 hex を残さない。例: 「dark_plus `#C586C0` を排除」ではなく「dark_plus 補完色を排除」と書く）:

```bash
! grep -iE '#4EC9B0|#C586C0|#b5cea8|#d7ba7d|#9CDCFE|#C8C8C8|#d4d4d4|#ce9178|#4FC1FF|#569cd6|#DCDCAA' lua/codedark26/{colors,theme}.lua
```

### `StorageClass` は constant 青（VS Code の `storage` scope 赤に引きずられない）

VS Code TextMate scope の `storage` は keyword 赤 `#ff7b72` だが、Vim ハイライトグループ `StorageClass` は **型系として constant 青 `#79c0ff`** に割り当てる（`Type` / `Structure` / `Typedef` と同じ）。両者は名前が似ているだけの**別概念**。TextMate scope `storage` の赤に引きずって `StorageClass` を赤にしないこと（過去に取り違えで実装誤りが発生）。

その他の Focus 寄せ先（README の表も参照）:
- 型・クラス・enum・namespace・数値・プロパティ → constant 青 `#79c0ff`
- 制御フロー（`Conditional` / `Repeat` / `Exception`）・`PreProc` / `Include` / `Define` / `Macro` → keyword 赤 `#ff7b72`
- escape（`SpecialChar`）・regex escape → tag 緑 `#7ee787`
- 演算子（`Operator`）・`Label` → 前景 `#c9d1d9`（色を付けない）

## 色 SSOT の取得方法

VS Code テーマ JSON を LLM に転記させると hex 値が劣化するリスクがある。色値を更新・確認するときは `curl` で raw JSON を取得してローカル Read で参照する（WebFetch 経由で読ませない）。継承チェーンは `2026-dark.json` → `dark_modern.json` → `dark_plus.json` → `dark_vs.json` の順に解決する。

- `terminal.ansi*` は全継承 JSON に未定義。`vim.g.terminal_color_0..15` は構文 / UI パレットから自前マッピングする（見落とすと terminal colors が空になる）。
- `panel.border` は 2026-dark で `#2A2B2CFF` に上書き済み（dark_modern の `#2B2B2B` ではない）。

## アルファ付き hex の扱い

`nvim_set_hl` の fg/bg はアルファ非対応。
- bg 用途: `#RRGGBB` + `blend = round((1 - AA/255) * 100)` を `theme.lua` 側でインライン指定。例: `#276782dd` (AA=0xdd=221) → `blend = 13`。
- fg 用途: blend 非対応のためソリッド色で代用。
- `colors.lua` にはベース色のみ保存し、blend は `theme.lua` に置く分離が保守的。

## 検証方法

自動テストフレームワークは導入しない慣習。ロード検証は headless Neovim で行う:

```bash
nvim --headless --clean --cmd "set rtp+=$(pwd)" -c "colorscheme codedark26" -c "lua assert(...)" -c "qa"
```

主要な寄せ先色は `nvim_get_hl` で assert する（例: `Type` / `Number` の fg が `#79c0ff`、`Conditional` の fg が `#ff7b72`）。`luac` / `luajit` が環境に無い場合は静的構文チェック未実施として明記する（nvim があればロード検証は可能）。
