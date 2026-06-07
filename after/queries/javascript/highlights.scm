; JavaScript Treesitter highlights override
; VS Code 2026 Dark (Focus) 互換のキーワードハイライト

; export を @keyword.import でハイライト（インポート概念との統一）
((identifier) @keyword.import
  (#eq? @keyword.import "export"))

; break / with を条件分岐扱いに（制御フロー構造の視認性向上）
((break_statement) @keyword.conditional)
((with_statement) @keyword.conditional)
