# codedark26

VS Code Dark 2026 (Focus) theme for Neovim — Lua-based, Neovim 0.5+

## 概要

`codedark26` は VS Code v1.113 で一般公開された **VS Code Dark 2026 テーマ**（`2026-dark.json`）を Neovim 専用カラースキームとして移植したプラグインです。

### Focus 統一パレット設計方針

VS Code Dark 2026 は「Focus」という設計思想に基づき、アクセントカラーを大幅に絞り込んでいます。`codedark26` はこの思想を忠実に再現するため、**`2026-dark.json` の実使用色のみ**を採用しています。

具体的には、`dark_plus` / `dark_vs` 由来の補完色（Type 緑 `#4EC9B0`、Control 紫 `#C586C0` 等）は一切持ち込まず、以下のように統一しています：

| 概念 | Focus 統一色 | 色コード |
|---|---|---|
| 型・クラス・enum・namespace・数値・プロパティ | constant 青 | `#79c0ff` |
| 制御フロー・例外・include・define | keyword 赤 | `#ff7b72` |
| 文字列内エスケープ・regex escape | tag 緑 | `#7ee787` |
| 演算子記号・ラベル | 前景レベル（色なし） | `#c9d1d9` |

この設計により「VS Code の Dark+ と型の色が違う」と感じる場合がありますが、これは意図した仕様です（Focus 統一感の再現）。

terminal colors の br magenta (index 13) が magenta (index 5) と同色 (`#d2a8ff`) になるのも同じ理由です（2026-dark パレットに紫系は function 紫のみ）。

## 必要条件

- Neovim 0.5 以上
- `termguicolors` 対応ターミナル（True Color）

## インストール

### lazy.nvim

```lua
{
  'coil398/codedark26',
  lazy = false,
  priority = 1000,
  config = function()
    require('codedark26').setup({
      -- オプション（下記参照）
    })
    vim.cmd('colorscheme codedark26')
  end,
}
```

### packer.nvim

```lua
use {
  'coil398/codedark26',
  config = function()
    require('codedark26').setup({})
    vim.cmd('colorscheme codedark26')
  end,
}
```

### vim-plug

```vim
Plug 'coil398/codedark26'
" 後で設定
colorscheme codedark26
```

## 使い方

```lua
-- init.lua
require('codedark26').setup({
  -- オプション（省略時はすべてデフォルト値）
})
vim.cmd('colorscheme codedark26')
```

または Vimscript から：

```vim
colorscheme codedark26
```

## setup() オプション

| オプション | 型 | デフォルト | 説明 |
|---|---|---|---|
| `style` | string | `'dark'` | テーマバリエーション（将来の light 受け口） |
| `transparent` | boolean | `false` | 背景を透過にする |
| `italic_comments` | boolean | `false` | コメントをイタリック表示 |
| `italic_inlayhints` | boolean | `false` | インライン型ヒントをイタリック表示 |
| `underline_links` | boolean | `false` | `@markup.link.*` を下線表示 |
| `disable_nvimtree_bg` | boolean | `false` | nvim-tree 背景を無効化 |
| `terminal_colors` | boolean | `true` | `:terminal` の 0-15 色をカラースキーム適用 |
| `color_overrides` | table | `{}` | 色パレット値の上書き（例: `{ vscBack = '#000000' }`） |
| `group_overrides` | table | `{}` | ハイライトグループの上書き（例: `{ Normal = { fg = '#ffffff' } }`） |

### 設定例

```lua
require('codedark26').setup({
  transparent = true,              -- ターミナル背景を活かす
  italic_comments = true,          -- コメントをイタリック
  color_overrides = {
    vscBack = '#0d1117',           -- 背景色を GitHub Dark に近づける
  },
  group_overrides = {
    CursorLine = { bg = '#1f2428' },
  },
})
```

## lualine 連携

> `require('codedark26').setup({...})` を lualine の設定より先に呼んでください（`color_overrides` / `transparent` 等の設定をテーマに反映するため）。

```lua
require('lualine').setup({
  options = {
    theme = 'codedark26',
  },
})
```

## 対応プラグイン

以下のプラグイン向けハイライトグループを定義しています：

1. **nvim-cmp** — CmpItemKind* / CmpItemAbbr* / CmpItemMenu
2. **gitsigns** — GitSigns{Add,Change,Delete} + Nr / Ln / Cul / Inline 系
3. **telescope** — TelescopeBorder / Matching / Selection / Title 系
4. **nvim-tree** — NvimTree{Normal,FolderName,GitDirty,...}
5. **neo-tree** — NeoTree{Normal,DirectoryName,Git*,...}
6. **indent-blankline** — IblIndent / IblScope
7. **bufferline** — BufferLine{Fill,Background,BufferSelected,...}
8. **which-key** — WhichKey / WhichKeyGroup / WhichKeyDesc / WhichKeyFloat

## ライセンス

MIT License — Copyright (c) 2026 coil398
