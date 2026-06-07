; TypeScript Treesitter highlights override
; VS Code 2026 Dark (Focus) 互換のキーワードハイライト
; 注: v2 では @type が constant 青 (#79c0ff) になる（dark_plus 補完色 #4EC9B0 は不採用）

; export を @keyword.import でハイライト（インポート概念との統一）
((identifier) @keyword.import
  (#eq? @keyword.import "export"))

; break / with を条件分岐扱いに（制御フロー構造の視認性向上）
((break_statement) @keyword.conditional)
((with_statement) @keyword.conditional)

; TypeScript の type import を型グループとして色分け
; 対象: `import { type Foo }` の "type" 部分（識別子として現れる箇所）
; → v2 では @type が constant 青になるため、type import も青でハイライトされる
((import_statement
  (import_specifier (identifier) @type))
  (#eq? @type "type"))
