-- ===================================================================================
-- Vim Color File
-- Original URL:    https://github.com/devsjc/vim-jb
-- Fork URL:        https://github.com/ms0503/vim-jb.lua
-- Filename:        lua/init.lua
-- Original Author: devsjc
-- Fork Author:     Sora Tonami
-- License:         The MIT License (MIT)
-- Based On:        https://github.com/drewtempelmeyer/palenight.vim
-- ===================================================================================

local jb = require('vim-jb')

function table.remove_by_key(table, key)
    local content = table[key]
    table[key] = nil
    return content
end

-- === Initialization ================================================================

vim.cmd('highlight clear')
vim.o.cursorline = true

if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.o.t_Co = 256
vim.o.t_Cs = '[4:3m'
vim.o.t_Ce = '[4:0m'

vim.g.colors_name = 'jb'
vim.g.jb_termcolors = 256

local config = jb.GetConfig()
local colors = jb.GetColors(config.style, config.overrides)

-- UI configuration
if config.enable_unicode then
    -- Use box drawing characters for vertical split
    table.remove_by_key(vim.opt.fillchars, 'vert')
    vim.opt.fillchars.vert = [[\│]]
    -- Use box drawing characters for gitgutter signs
    vim.g.gitgutter_sign_added = '┃'
    vim.g.gitgutter_sign_modified = '┃'
    vim.g.gitgutter_sign_removed = '┃'
    vim.g.gitgutter_sign_removed_first_line = '┓'
    vim.g.gitgutter_sign_removed_above_and_below = '╏'
    vim.g.gitgutter_sign_modified_removed = '┨'
end
-- Remove the tilde from the end of the buffer (ending whitespace required!)
table.remove_by_key(vim.opt.fillchars, 'eob')
vim.opt.fillchars.eob = [[\ ]]

-- === FUNCTIONS =====================================================================

-- This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
-- Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
local function h(group, style)
    if not config.enable_italic then
        if vim.fn.has_key(style, 'cterm') and style['cterm'] == 'italic' then
            style.cterm = nil
        end
        if vim.fn.has_key(style, 'gui') and style['gui'] == 'italic' then
            style.gui = nil
        end
    end
    local ctermfg = (vim.fn.has_key(style, 'fg') and style.fg.cterm or 'NONE')
    local ctermbg = (vim.fn.has_key(style, 'bg') and style.bg.cterm or 'NONE')
    vim.cmd(
        'highlight '
            .. group
            .. ' guifg='
            .. (vim.fn.has_key(style, 'fg') and style.fg.gui or 'NONE')
            .. ' guibg='
            .. (vim.fn.has_key(style, 'bg') and style.bg.gui or 'NONE')
            .. ' guisp='
            .. (vim.fn.has_key(style, 'sp') and style.sp.gui or 'NONE')
            .. ' gui='
            .. (vim.fn.has_key(style, 'gui') and style.gui or 'NONE')
            .. ' ctermfg='
            .. ctermfg
            .. ' ctermbg='
            .. ctermbg
            .. ' cterm='
            .. (vim.fn.has_key(style, 'cterm') and style.cterm or 'NONE')
            .. ' ctermul='
            .. (vim.fn.has_key(style, 'ctermul') and style.ctermul or 'NONE')
    )
end

-- === JETBRAINS COLOR GROUPS ========================================================

-- General
h('JBDefault', { fg = colors.text }) -- Standard text
h('JBHyperlink', { fg = colors.link, gui = 'underline', cterm = 'underline' })
h('JBTodo', { fg = colors.todo }) -- TODOs
h('JBSearchResult', { bg = colors.search }) -- Search results
h('JBFoldedText', { fg = colors.comment, bg = colors.folded }) -- Folded text
h(
    'JBError',
    { gui = 'underline', cterm = 'undercurl', sp = colors.err, ctermul = 'red' }
) -- Doesn't match JB exactly, can't do separate color undercurls in terminal
h('JBWarning', {
    gui = 'undercurl',
    cterm = 'undercurl',
    sp = colors.warning,
    ctermul = 'yellow',
})
h('JBCursor', { fg = colors.editor, bg = colors.comment })

-- Language defaults
h('JBString', { fg = colors.string }) -- Strings
h('JBStringRef', { fg = colors.stringref }) -- References wifhin strings
h('JBNumber', { fg = colors.number }) -- Numbers (floats, ints)
h('JBKeyword', { fg = colors.keyword }) -- Keywords
h('JBFunction', { fg = colors['function'] }) -- Functions (calls and definitions)
h('JBComment', { fg = colors.comment }) -- Comment text
h('JBCommentRef', { fg = colors.commentref }) -- References within comments e.g. to classes
h('JBDocComment', { fg = colors.doccomment }) -- Documentation comments
h('JBConstant', { fg = colors.const }) -- Constants
h('JBType', { fg = colors.type }) -- Types
h('JBTag', { fg = colors.tag }) -- Tags
h(
    'JBMatchedBracket',
    { fg = colors.text, bg = colors.folded, gui = 'bold', cterm = 'bold' }
) -- Matching brackets
h('JBStruct', { fg = colors.struct })
h('JBVirtualText', { fg = colors.virtual }) -- Virtual text

-- Diff and Merge
h('JBDiffAddedLine', { bg = colors.diffadd }) -- Newly inserted lines in diff
h('JBDiffChangedLine', { bg = colors.diffmod }) -- Changed lines in diff
h('JBDiffChangedText', { bg = colors.difftext }) -- Changed text in diff
h('JBDiffDeletedLine', { bg = colors.diffdel }) -- Deleted lines in diff

-- Gutter
h('JBGutterAddedLine', { fg = colors.gutteradd }) -- Added lines in gutter
h('JBGutterChangedLine', { fg = colors.guttermod }) -- Changed lines in gutter
h('JBGutterDeletedLine', { fg = colors.gutterdel }) -- Deleted lines in gutter
h('JBGutterLineNr', { fg = colors.virtual }) -- Line numbers in gutter

-- UI
h('JBEditorBG', { bg = colors.editor }) -- Editor background
h('JBTree', { fg = colors.text, bg = colors.folded }) -- Tree text
h('JBTreeBG', { bg = colors.folded }) -- Tree background
h('JBDivider', { fg = colors.diffdel }) -- Divider between panes

-- === VIM HIGHLIGHT GROUPS ==========================================================
-- See :help highlight-groups for more information

-- --- Major ---
vim.api.nvim_set_hl(0, 'Normal', { link = 'JBDefault' })
vim.api.nvim_set_hl(0, 'Comment', { link = 'JBComment' })
vim.api.nvim_set_hl(0, 'Constant', { link = 'JBConstant' })
vim.api.nvim_set_hl(0, 'Identifier', { link = 'JBFunction' })
vim.api.nvim_set_hl(0, 'Statement', { link = 'JBKeyword' })
vim.api.nvim_set_hl(0, 'PreProc', { link = 'JBCommentRef' })
vim.api.nvim_set_hl(0, 'Type', { link = 'JBType' })
vim.api.nvim_set_hl(0, 'Special', { link = 'JBKeyword' })
h('Underline', { gui = 'underline', cterm = 'underline' })
h('Ignore', {})
vim.api.nvim_set_hl(0, 'Error', { link = 'JBError' })
vim.api.nvim_set_hl(0, 'Todo', { link = 'JBTodo' })

-- --- Minor ---
vim.api.nvim_set_hl(0, 'String', { link = 'JBString' })
vim.api.nvim_set_hl(0, 'Character', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'Number', { link = 'JBNumber' })
vim.api.nvim_set_hl(0, 'Boolean', { link = 'Number' })
vim.api.nvim_set_hl(0, 'Float', { link = 'Number' })
vim.api.nvim_set_hl(0, 'Function', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'Keyword', { link = 'JBKeyword' })
vim.api.nvim_set_hl(0, 'Conditional', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'Repeat', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'Label', { link = 'JBVirtualText' })
vim.api.nvim_set_hl(0, 'Include', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'Define', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'Macro', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'SpecialChar', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'Operator', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'Exception', { link = 'Error' })
vim.api.nvim_set_hl(0, 'PreCondit', { link = 'PreProc' })
vim.api.nvim_set_hl(0, 'StorageClass', { link = 'Type' })
vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })
vim.api.nvim_set_hl(0, 'Typedef', { link = 'Type' })
vim.api.nvim_set_hl(0, 'Tag', { link = 'JBTag' })
vim.api.nvim_set_hl(0, 'Delimiter', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'SpecialComment', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'Debug', { link = 'Tag' })

-- --- Text ---
vim.api.nvim_set_hl(0, 'Cursor', { link = 'JBCursor' })
vim.api.nvim_set_hl(0, 'LineNr', { link = 'JBGutterLineNr' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { link = 'JBCommentRef' })
vim.api.nvim_set_hl(0, 'NormalNC', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'Folded', { link = 'JBFoldedText' })
vim.api.nvim_set_hl(0, 'FoldColumn', { link = 'Folded' })
vim.api.nvim_set_hl(0, 'SignColumn', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'Search', { link = 'JBSearchResult' })
vim.api.nvim_set_hl(0, 'IncSearch', { link = 'JBDiffChangedText' })
vim.api.nvim_set_hl(0, 'CurSearch', { link = 'IncSearch' })
vim.api.nvim_set_hl(0, 'ColorColumn', { link = 'JBTreeBG' })
vim.api.nvim_set_hl(0, 'Conceal', { link = 'JBGutterLineNr' })
vim.api.nvim_set_hl(0, 'vCursor', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'iCursor', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'lCursor', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'CursorIM', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'CursorLine', { link = 'JBTreeBG' })
vim.api.nvim_set_hl(0, 'CursorColumn', { link = 'CursorLine' })
vim.api.nvim_set_hl(0, 'MatchParen', { link = 'JBMatchedBracket' })
vim.api.nvim_set_hl(0, 'Title', { link = 'Constant' })

-- --- Diff and Merge ---
vim.api.nvim_set_hl(0, 'Added', { link = 'JBGutterAddedLine' })
vim.api.nvim_set_hl(0, 'Changed', { link = 'JBGutterChangedLine' })
vim.api.nvim_set_hl(0, 'DiffAdd', { link = 'JBDiffAddedLine' })
vim.api.nvim_set_hl(0, 'DiffChange', { link = 'JBDiffChangedLine' })
vim.api.nvim_set_hl(0, 'DiffText', { link = 'JBDiffChangedText' })
vim.api.nvim_set_hl(0, 'DiffDelete', { link = 'JBDiffDeletedLine' })

-- --- Diagnostics ---
vim.api.nvim_set_hl(0, 'ErrorText', { link = 'Error' })
vim.api.nvim_set_hl(0, 'WarningText', { link = 'JBWarning' })
vim.api.nvim_set_hl(0, 'InfoText', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'HintText', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'ErrorLine', {})
vim.api.nvim_set_hl(0, 'WarningLine', {})
vim.api.nvim_set_hl(0, 'InfoLine', {})
vim.api.nvim_set_hl(0, 'HintLine', {})
vim.api.nvim_set_hl(0, 'ErrorMsg', { link = 'Error' })
vim.api.nvim_set_hl(0, 'WarningMsg', { link = 'JBWarning' })
vim.api.nvim_set_hl(0, 'Question', { link = 'JBWarning' })
h('ModeMsg', { fg = colors.text, gui = 'bold', cterm = 'bold' }) -- Mode message
h('MoreMsg', { fg = colors['function'], gui = 'bold', cterm = 'bold' }) -- More message
vim.api.nvim_set_hl(0, 'SpellBad', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'SpellCap', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'SpellRare', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'SpellLocal', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'NonText', { link = 'LineNr' })
vim.api.nvim_set_hl(0, 'WhiteSpace', { link = 'LineNr' })
vim.api.nvim_set_hl(0, 'SpecialKey', { link = 'LineNr' })

-- --- UI ---
vim.api.nvim_set_hl(0, 'Pmenu', { link = 'JBTree' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'PmenuSel', { link = 'Cursor' })
h('PmenuKind', { fg = colors.type, bg = colors.folded }) -- Popup menu kind
h('PmenuExtra', { fg = colors.comment, bg = colors.folded }) -- Popup menu extra
vim.api.nvim_set_hl(0, 'WildMenu', { link = 'PmenuSel' })
vim.api.nvim_set_hl(0, 'Directory', { link = 'String' })
h('FloatBorder', { fg = colors.diffdel, bg = colors.editor }) -- Float border
vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'Terminal', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { link = 'JBEditorBG' })
vim.api.nvim_set_hl(0, 'StatusLine', { link = 'JBTree' })
vim.api.nvim_set_hl(0, 'StatusLineTerm', { link = 'StatusLine' })
h('StatusLineNC', { fg = colors.diffdel, bg = colors.folded }) -- Status line inactive
vim.api.nvim_set_hl(0, 'StatusLineTermNC', { link = 'StatusLineNC' })
vim.api.nvim_set_hl(0, 'TabLine', { link = 'JBTree' })
vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'JBTree' })
vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'VertSplit', { link = 'JBDivider' })
vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'VertSplit' })
vim.api.nvim_set_hl(0, 'ToolbarButton', { link = 'Cursor' })

-- Visual mode
h('Visual', { bg = colors.folded }) -- Visual selection
h('VisualNOS', { bg = colors.folded, gui = 'underline', cterm = 'underline' }) -- Visual selection
h('QuickFixLine', { fg = colors.link, gui = 'bold', cterm = 'bold' }) -- Quickfix selected line
vim.api.nvim_set_hl(0, 'Debug', { link = 'Tag' })
h('debugBreakpoint', { fg = colors.text, bg = colors.err1 }) -- Debug

-- Terminal
if vim.fn.has('terminal') then
    vim.g.terminal_ansi_colors = {
        colors.folded.gui,
        colors.err1.gui,
        colors.string.gui,
        colors.tag.gui,
        colors.number.gui,
        colors.const.gui,
        colors.keyword.gui,
        colors.comment.gui,
        colors.diffdel.gui,
        colors.err.gui,
        colors.todo.gui,
        colors.warning.gui,
        colors['function'].gui,
        colors.instruction.gui,
        colors.type.gui,
        colors.commentref.gui,
    }
end

-- === LANGUAGE SPECIFIC HIGHLIGHTS ==================================================

-- --- Python (python/polyglot) ---
vim.api.nvim_set_hl(0, 'pythonException', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'pythonDecoratorName', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'pythonDecorator', { link = 'Tag' })

-- --- Go (vim-go/polyglot) ---
vim.api.nvim_set_hl(0, 'goPackage', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'goBuiltins', { link = 'Type' })
vim.api.nvim_set_hl(0, 'goFunction', { link = 'Function' })
vim.api.nvim_set_hl(0, 'goField', { link = 'JBStruct' })

-- --- JSON (vim-json/polyglot) ---
vim.api.nvim_set_hl(0, 'jsonKeyword', { link = 'Constant' })
vim.api.nvim_set_hl(0, 'jsonBoolean', { link = 'Keyword' })

-- --- Markdown ---
vim.api.nvim_set_hl(0, 'markdownCode', { link = 'String' })
vim.api.nvim_set_hl(0, 'markdownCodeBlock', { link = 'String' })
vim.api.nvim_set_hl(0, 'markdownCodeDelimiter', { link = 'String' })
vim.api.nvim_set_hl(0, 'markdownBlockQuote', { link = 'String' })
vim.api.nvim_set_hl(0, 'markdownListMarker', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'markdownOrderedListMarker', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'markdownRule', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'markdownH1', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownH2', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownH3', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownH4', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownH5', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownH6', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownHeadingRule', { link = 'Const' })
vim.api.nvim_set_hl(0, 'markdownUrl', { link = 'JBHyperlink' })
vim.api.nvim_set_hl(0, 'markdownUrlDelimiter', { link = 'JBHyperlink' })

-- --- Markdown (vim-markdown/polyglot) ---
vim.api.nvim_set_hl(0, 'mkdCode', { link = 'String' })
vim.api.nvim_set_hl(0, 'mkdSnippetSHELL', { link = 'String' })
vim.api.nvim_set_hl(0, 'mkdURL', { link = 'JBHyperlink' })
vim.api.nvim_set_hl(0, 'mkdHeading', { link = 'Const' })

-- --- JavaScript (vim-javascript/polyglot) ---
vim.api.nvim_set_hl(0, 'jsDecorator', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'jsDecoratorFunction', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'jsxTagName', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'jsxAttrib', { link = 'Normal' })

-- --- Rust (rust.vim/polyglot) ---
vim.api.nvim_set_hl(0, 'rustTrait', { link = 'Text' })
vim.api.nvim_set_hl(0, 'rustConstant', { link = 'Constant' })
vim.api.nvim_set_hl(0, 'rustModPath', { link = 'Text' })
vim.api.nvim_set_hl(0, 'rustEnum', { link = 'Text' })
vim.api.nvim_set_hl(0, 'rustIdentifier', { link = 'Text' })
vim.api.nvim_set_hl(0, 'rustAttribute', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'rustUnsafeKeyword', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'rustStructure', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'rustMacro', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'rustMacroRepeatDelimiters', { link = 'rustMacro' })
vim.api.nvim_set_hl(0, 'rustMacroVariable', { link = 'Function' })
vim.api.nvim_set_hl(0, 'rustLifetime', { link = 'JBStruct' })
vim.api.nvim_set_hl(0, 'rustLabel', { link = 'JBStruct' })
vim.api.nvim_set_hl(0, 'rustPanic', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'rustStorage', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'rustCharacter', { link = 'String' })
vim.api.nvim_set_hl(0, 'rustSelf', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'rustAsmConstExpr', { link = 'Constant' })
vim.api.nvim_set_hl(0, 'rustAsmConst', { link = 'Constant' })
vim.api.nvim_set_hl(0, 'rustSigil', { link = 'Text' })
vim.api.nvim_set_hl(0, 'rustCommentLineDoc', { link = 'JBDocComment' })

-- --- TypeScript (vim-typescript/polyglot) ---
vim.api.nvim_set_hl(0, 'typescriptStorageClass', { link = 'Text' })
vim.api.nvim_set_hl(0, 'typescriptEndColons', { link = 'Text' })
vim.api.nvim_set_hl(0, 'typescriptMessage', { link = 'String' })
vim.api.nvim_set_hl(0, 'typescriptGlobalObjects', { link = 'Constant' })
vim.api.nvim_set_hl(0, 'typescriptBraces', { link = 'Text' })
vim.api.nvim_set_hl(0, 'typescriptParens', { link = 'Text' })

-- --- HTML ---
vim.api.nvim_set_hl(0, 'htmlTag', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'htmlEndTag', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'htmlTagN', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'htmlTagName', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'htmlSpecialTagName', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'htmlArg', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'htmlScriptTag', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'htmlString', { link = 'String' })

-- --- Vim ---
vim.api.nvim_set_hl(0, 'vimLet', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'vimFunction', { link = 'Function' })
vim.api.nvim_set_hl(0, 'vimIsCommand', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'vimUserFunc', { link = 'Function' })
vim.api.nvim_set_hl(0, 'vimFuncName', { link = 'Function' })

-- --- Kotlin (kotlin-vim/polyglot) ---
vim.api.nvim_set_hl(0, 'ktDocComment', { link = 'JBDocComment' })
vim.api.nvim_set_hl(0, 'ktDocTag', { link = 'JBStringRef' })
vim.api.nvim_set_hl(0, 'ktDocTagParam', { link = 'Text' })
vim.api.nvim_set_hl(0, 'ktAnnotation', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'ktComplexInterpolationBrace', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'ktLabel', { link = 'Number' })
vim.api.nvim_set_hl(0, 'ktArrow', { link = 'Text' })
vim.api.nvim_set_hl(0, 'ktType', { link = 'Text' })
vim.api.nvim_set_hl(0, 'ktModifier', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'ktStructure', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'ktSimpleInterpolation', { link = 'Keyword' })

-- === PLUGIN SPECIFIC HIGHLIGHTS (NON-LANGUAGE) =====================================

-- --- GitGutter ---
vim.api.nvim_set_hl(0, 'GitGutterAdd', { link = 'JBGutterAddedLine' })
vim.api.nvim_set_hl(0, 'GitGutterChange', { link = 'JBGutterChangedLine' })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { link = 'JBGutterDeletedLine' })

-- --- Fugitive ---
vim.api.nvim_set_hl(0, 'diffAdded', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'diffRemoved', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'gitDiff', { link = 'Comment' })

-- --- FZF ---
vim.g.fzf_colors = {
    fg = { 'fg', 'Normal' },
    hl = { 'fg', 'Search' },
    ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
    ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
    ['hl+'] = { 'fg', 'Cursor' },
    info = { 'fg', 'Comment' },
    gutter = { 'bg', 'JBEditorBG' },
    border = { 'fg', 'VertSplit' },
    prompt = { 'fg', 'ModeMsg' },
    pointer = { 'fg', 'Function' },
    marker = { 'fg', 'Function' },
    spinner = { 'fg', 'Warning' },
    header = { 'fg', 'Const' },
}

-- --- MistFly ---
h('MistflyNormal', { fg = colors.editor, bg = colors.commentref }) -- Normal text
h('MistflyCommand', { fg = colors.editor, bg = colors.warning }) -- Command text
h('MistflyInsert', { fg = colors.editor, bg = colors['function'] }) -- Insert text
h('MistflyVisual', { fg = colors.editor, bg = colors.keyword }) -- Visual text
h('MistflyReplace', { fg = colors.editor, bg = colors.err1 }) -- Replace text

-- --- Fern ---
vim.api.nvim_set_hl(0, 'FernRootSymbol', { link = 'String' })
vim.api.nvim_set_hl(0, 'FernRootText', { link = 'String' })
vim.api.nvim_set_hl(0, 'FernBranchSymbol', { link = 'String' })
vim.api.nvim_set_hl(0, 'FernBranchText', { link = 'ModeMsg' })
vim.api.nvim_set_hl(0, 'FernLeafSymbol Function', { link = '' })
vim.api.nvim_set_hl(0, 'FernGitStatusIndex', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'FernGitStatusWorktree', { link = 'DiffText' })
vim.api.nvim_set_hl(0, 'FernGitStatusUntracked', { link = 'DiffAdd' })

-- --- NERDTree ---
vim.api.nvim_set_hl(0, 'NERDTreeDir', { link = 'ModeMsg' })
vim.api.nvim_set_hl(0, 'NERDTreeDirSlash', { link = 'ModeMsg' })
vim.api.nvim_set_hl(0, 'NERDTreeOpenable', { link = 'ModeMsg' })
vim.api.nvim_set_hl(0, 'NERDTreeClosable', { link = 'ModeMsg' })
vim.api.nvim_set_hl(0, 'NERDTreeFile', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NERDTreeExecFile', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NERDTreeUp', { link = 'String' })
vim.api.nvim_set_hl(0, 'NERDTreeCWD', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NERDTreeHelp', { link = 'Normal' })

-- --- ALE (github.com/dense-analysis/ale) ---
vim.api.nvim_set_hl(0, 'ALEError', { link = 'JBError' })
vim.api.nvim_set_hl(0, 'ALEWarning', { link = 'JBWarning' })
vim.api.nvim_set_hl(0, 'ALEInfo', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'ALEErrorSign', { link = 'JBError' })
vim.api.nvim_set_hl(0, 'ALEWarningSign', { link = 'JBWarning' })
vim.api.nvim_set_hl(0, 'ALEInfoSign', { link = 'Underline' })

-- --- COC (github.com/neoclide/coc.nvim) ---
vim.api.nvim_set_hl(0, 'CocErrorSign', { link = 'JBError' })
vim.api.nvim_set_hl(0, 'CocWarningSign', { link = 'JBWarning' })
vim.api.nvim_set_hl(0, 'CocInfoSign', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'CocHintSign', { link = 'Underline' })
vim.api.nvim_set_hl(0, 'CocMarkdownCode', { link = 'String' })
vim.api.nvim_set_hl(0, 'CocPumShortcut', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'CocPumMenu', { link = 'Pmenu' })
vim.api.nvim_set_hl(0, 'CocMenuSel', { link = 'PmenuSel' })
vim.api.nvim_set_hl(0, 'CocInlayHint', { link = 'LineNr' })
vim.api.nvim_set_hl(0, 'CocGitAddedSign', { link = 'JBGutterAddedLine' })
vim.api.nvim_set_hl(0, 'CocGitChangeSign', { link = 'JBGutterChangedLine' })
vim.api.nvim_set_hl(0, 'CocGitRemovedSign', { link = 'JBGutterDeletedLine' })

-- === NEOVIM ========================================================================

if vim.fn.has('nvim') then
    vim.api.nvim_set_hl(0, 'Statusline', { link = 'StatusLine' })
    vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'JBTree' })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { link = 'ErrorText' })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { link = 'WarningText' })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { link = 'InfoText' })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'DiagnosticError', { link = 'ErrorText' })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { link = 'WarningText' })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { link = 'InfoText' })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { link = 'ErrorText' })
    vim.api.nvim_set_hl(
        0,
        'DiagnosticVirtualTextWarn',
        { link = 'WarningText' }
    )
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { link = 'InfoText' })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { link = 'ErrorText' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { link = 'WarningText' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { link = 'InfoText' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { link = 'HintText' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignError', { link = 'ErrorText' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { link = 'WarningText' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { link = 'InfoText' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsFloatingError',
        { link = 'DiagnosticFloatingError' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsFloatingWarning',
        { link = 'DiagnosticFloatingWarn' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsFloatingInformation',
        { link = 'DiagnosticFloatingInfo' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsFloatingHint',
        { link = 'DiagnosticFloatingHint' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsDefaultError',
        { link = 'DiagnosticError' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsDefaultWarning',
        { link = 'DiagnosticWarn' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsDefaultInformation',
        { link = 'DiagnosticInfo' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsDefaultHint',
        { link = 'DiagnosticHint' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsVirtualTextError',
        { link = 'DiagnosticVirtualTextError' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsVirtualTextWarning',
        { link = 'DiagnosticVirtualTextWarn' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsVirtualTextInformation',
        { link = 'DiagnosticVirtualTextInfo' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsVirtualTextHint',
        { link = 'DiagnosticVirtualTextHint' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsUnderlineError',
        { link = 'DiagnosticUnderlineError' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsUnderlineWarning',
        { link = 'DiagnosticUnderlineWarn' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsUnderlineInformation',
        { link = 'DiagnosticUnderlineInfo' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsUnderlineHint',
        { link = 'DiagnosticUnderlineHint' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsSignError',
        { link = 'DiagnosticSignError' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsSignWarning',
        { link = 'DiagnosticSignWarn' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsSignInformation',
        { link = 'DiagnosticSignInfo' }
    )
    vim.api.nvim_set_hl(
        0,
        'LspDiagnosticsSignHint',
        { link = 'DiagnosticSignHint' }
    )
    vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'LspCodeLens', { link = 'InfoText' })
    vim.api.nvim_set_hl(0, 'LspCodeLensSeparator', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { link = 'Search' })
    vim.api.nvim_set_hl(0, 'TermCursor', { link = 'Cursor' })
    vim.api.nvim_set_hl(0, 'healthError', { link = 'ErrorText' })
    vim.api.nvim_set_hl(0, 'healthSuccess', { link = 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'healthWarning', { link = 'WarningText' })
end

-- === FOOTER ========================================================================

-- Must appear at the end of the file to work around this oddity:
-- https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
vim.o.background = 'dark'
