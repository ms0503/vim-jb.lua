---@meta

---@class vim-jb.Color color definition
---@field cterm number xterm-256color color index
---@field gui   string #RRGGBB or well-known color name

---@alias vim-jb.ColorNames 'comment'|'commentref'|'const'|'diffadd'|'diffdel'|'diffmod'|'difftext'|'doccomment'|'editor'|'err'|'err1'|'folded'|'function'|'gutteradd'|'gutterdel'|'guttermod'|'instruction'|'keyword'|'link'|'number'|'search'|'string'|'stringref'|'struct'|'tag'|'text'|'todo'|'type'|'virtual'|'warning' color names of palette

---@alias vim-jb.ColorPalette {[vim-jb.ColorNames]: vim-jb.ColorPaletteEntry} color palette

---@class vim-jb.ColorPaletteEntry color entry of palette
---@field hex   string   #RRGGBB
---@field rgb   number[] RGB color decimals
---@field xterm number   xterm-256color color index

---@alias vim-jb.ColorPalettes {[vim-jb.Variants]: vim-jb.ColorPalette} color palette each variant

---@alias vim-jb.Colors {[vim-jb.ColorNames]: vim-jb.Color} theme colors

---@class vim-jb.Config vim-jb configuration
---@field enable_italic?  boolean         whether italic text is enabled
---@field enable_unicode? boolean         whether unicode text is enabled
---@field overrides?      vim-jb.Colors   theme overrides
---@field style?          vim-jb.Variants theme variant
---@field transparent?    boolean         whether to disable setting the background color

---@class vim-jb.HighlightStyle settings of highlight style
---@field bg?      vim-jb.Color background color
---@field cterm?   string       style on console
---@field ctermul? string       color of underline on console
---@field fg?      vim-jb.Color foreground color
---@field gui?     string       style on GUI
---@field sp?      vim-jb.Color color of special span

---@alias vim-jb.Variants 'dark'|'light'|'mid' theme variants
