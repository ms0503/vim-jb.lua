---@meta

---@class vim-jb.Color color definition
---@field gui   string #RRGGBB or well-known color name
---@field cterm number xterm-256color color index

---@alias vim-jb.ColorNames 'editor'|'folded'|'diffdel'|'virtual'|'comment'|'gutterdel'|'commentref'|'text'|'err'|'err1'|'type'|'keyword'|'tag'|'warning'|'todo'|'gutteradd'|'doccomment'|'diffadd'|'search'|'string'|'stringref'|'number'|'function'|'link'|'guttermod'|'struct'|'diffmod'|'difftext'|'const'|'instruction' color names of palette

---@alias vim-jb.ColorPalette {[vim-jb.ColorNames]: vim-jb.ColorPaletteEntry} color palette

---@class vim-jb.ColorPaletteEntry color entry of palette
---@field hex   string   #RRGGBB
---@field rgb   number[] RGB color decimals
---@field xterm number   xterm-256color color index

---@alias vim-jb.ColorPalettes {[vim-jb.Variants]: vim-jb.ColorPalette} color palette each variant

---@alias vim-jb.Colors {[vim-jb.ColorNames]: vim-jb.Color} theme colors

---@class vim-jb.Config vim-jb configuration
---@field style?          vim-jb.Variants theme variant
---@field overrides?      vim-jb.Colors   theme overrides
---@field enable_italic?  boolean         whether italic text is enabled
---@field enable_unicode? boolean         whether unicode text is enabled

---@class vim-jb.HighlightStyle settings of highlight style
---@field fg?      vim-jb.Color foreground color
---@field bg?      vim-jb.Color background color
---@field gui?     string       style on GUI
---@field cterm?   string       style on console
---@field sp?      vim-jb.Color color of special span
---@field ctermul? string       color of underline on console

---@alias vim-jb.Variants 'dark'|'mid'|'light' theme variants
