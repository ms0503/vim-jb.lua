-- =============================================================================
-- Original URL:        https://github.com/devsjc/vim-jb
-- Original Filename:   autoload/jb.vim
-- Original Author:     devsjc
-- Fork URL:            https://github.com/ms0503/vim-jb.lua
-- Fork Filename:       lua/vim-jb/util.lua
-- Fork Author:         Sora Tonami
-- License:             The MIT License (MIT)
-- Based On:            https://github.com/sainnhe/sonokai
-- =============================================================================

local jb = {}

local path = debug.getinfo(1, 'S').source:sub(2):match('^(.*)/')
    .. '/palettes.json'
local flines = vim.fn.readfile(path)
---@type vim-jb.ColorPalettes
local jb_palettes = vim.fn.json_decode(vim.fn.join(flines))
---@type vim-jb.Colors
local colors = {}

---@param opts? vim-jb.Config config overrides
---@return vim-jb.Config -- current config (or default config if not configured)
function jb.GetConfig(opts)
    opts = opts or {}
    return {
        style = opts.style or vim.fn.get(vim.g, 'jb_style', 'dark'),
        overrides = opts.overrides
            or vim.fn.get(vim.g, 'jb_color_overrides', {}),
        enable_italic = opts.enable_italic
            or vim.fn.get(vim.g, 'jb_enable_italic', false),
        enable_unicode = opts.enable_unicode
            or vim.fn.get(vim.g, 'jb_enable_unicode', false),
    }
end

---@param style?     vim-jb.Variants theme style
---@param overrides? vim-jb.Colors   theme overrides
---@return vim-jb.Colors -- theme colors
function jb.GetColors(style, overrides)
    -- If style is anything other than 'dark', 'mid', 'light', set it's value to 'dark'
    style = style == 'mid' and 'mid' or style == 'light' and 'light' or 'dark'
    overrides = overrides or {}
    -- Load the palette according to the style
    local palettes_dict = vim.fn.get(jb_palettes, style, {})
    -- Populate the colors dictionary
    for key, val in pairs(palettes_dict) do
        colors[key] =
            vim.fn.get(overrides, key, { gui = val.hex, cterm = val.xterm })
    end

    return colors
end

return jb
