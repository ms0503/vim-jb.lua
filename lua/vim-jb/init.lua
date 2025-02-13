-- === LUA MODULE ====================================================================

local jb = require('vim-jb.util')

local M = {}

---@type {light?: string, dark?: string}
M.styles = {}

---@param opts vim-jb.Config
function M.load(opts)
    opts = jb.GetConfig(opts)
    local bg = vim.o.background
    local style_bg = opts.style == 'light' and 'light' or 'dark'

    if bg ~= style_bg then
        if vim.g.colors_name == 'jb-' .. opts.style then
            opts.style = bg == 'light' and (M.styles.light or 'light')
                or (M.styles.dark or 'dark')
        elseif not opts.transparent then
            vim.o.background = style_bg
        end
    end
    M.styles[bg or style_bg] = opts.style
    require('vim-jb.colors')
end

return M
