-- ==================================================================================
-- Original URL:    https://github.com/devsjc/vim-jb
-- Fork URL:        https://github.com/ms0503/vim-jb.lua
-- Filename:        lua/vim-jb/init.lua
-- Original Author: devsjc
-- Fork Author:     Sora Tonami
-- License:         The MIT License (MIT)
-- Based On:        https://github.com/sainnhe/sonokai
-- ==================================================================================

local jb = {}

local path = vim.fn.expand('<sfile>:p:h') .. '/palettes.json'
local flines = vim.fn.readfile(path)
local jb_palettes = vim.fn.json_decode(vim.fn.join(flines))
local colors = {}

function jb.GetConfig()
    return {
        style = vim.fn.get(vim.g, 'jb_style', 'dark'),
        overrides = vim.fn.get(vim.g, 'jb_color_overrides', {}),
        enable_italic = vim.fn.get(vim.g, 'jb_enable_italic', false),
        enable_unicode = vim.fn.get(vim.g, 'jb_enable_unicode', false),
    }
end

function jb.GetColors(style, overrides)
    -- If style is anything other than 'dark', 'mid', 'light', set it's value to 'dark'
    local style = style == 'mid' and 'mid'
        or style == 'light' and 'light'
        or 'dark'
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
