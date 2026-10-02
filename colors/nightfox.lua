vim.cmd 'highlight clear'
vim.cmd 'syntax reset'
vim.g.colors_name = 'nightfox'

local p = nil
if vim.opt.background:get() == "dark" then
  -- Nordfox ----------------------------------------------------------------
  p = {
    -- backgrounds
    bg        = "#2e3440",  -- bg1: default bg
    bg_float  = "#232831",  -- bg0: statusline, floats
    bg_hl     = "#39404f",  -- bg2: colorcolumn, folds
    bg_cur    = "#444c5e",  -- bg3: cursorline
    bg_vis    = "#3e4a5b",  -- sel0: visual selection, popup bg
    bg_search = "#4f6074",  -- sel1: search bg, popup sel bg
    conceal   = "#5a657d",  -- bg4: conceal, border

    -- foregrounds
    fg       = "#cdcecf",  -- fg1: default fg
    fg_light = "#c7cdd9",  -- fg0
    fg_dim   = "#abb1bb",  -- fg2: statusline, brackets, operators
    fg_dark  = "#7e8188",  -- fg3: line numbers, fold column
    comment  = "#60728a",

    -- colors (base)
    black   = "#3b4252",
    red     = "#bf616a",
    green   = "#a3be8c",
    yellow  = "#ebcb8b",
    blue    = "#81a1c1",
    magenta = "#b48ead",
    cyan    = "#88c0d0",
    orange  = "#c9826b",
    pink    = "#bf88bc",

    -- emphatic variants: brighter (dark theme = more lightness = more visible)
    red_e     = "#d06f79",
    green_e   = "#b1d196",
    yellow_e  = "#f0d399",
    blue_e    = "#8cafd2",
    magenta_e = "#c895bf",
    cyan_e    = "#93ccdc",
    orange_e  = "#d89079",
    pink_e    = "#d092ce",

    -- subtle variants: dimmer (less lightness)
    red_s     = "#a54e56",
    green_s   = "#8aa872",
    yellow_s  = "#d9b263",
    blue_s    = "#668aab",
    magenta_s = "#9d7495",
    cyan_s    = "#69a7ba",
    orange_s  = "#b46950",
    pink_s    = "#a96ca5",

    -- diff backgrounds (bg blended toward color at 0.15)
    diff_add    = "#3c4547",
    diff_delete = "#403843",
    diff_change = "#364150",
    diff_text   = "#3d515f",

    -- diagnostic backgrounds (bg blended toward diag color at 0.2)
    diag_error = "#4b3d48",
    diag_warn  = "#54524f",
    diag_info  = "#3f4a5a",
    diag_hint  = "#45504f",
  }
else
  -- Dayfox -----------------------------------------------------------------
  p = {
    -- backgrounds
    bg        = "#f6f2ee",  -- bg1: default bg
    bg_float  = "#e4dcd4",  -- bg0: statusline, floats
    bg_hl     = "#dbd1dd",  -- bg2: colorcolumn, folds
    bg_cur    = "#d3c7bb",  -- bg3: cursorline
    bg_vis    = "#e7d2be",  -- sel0: visual selection, popup bg
    bg_search = "#a4c1c2",  -- sel1: search bg, popup sel bg
    conceal   = "#aab0ad",  -- bg4: conceal, border

    -- foregrounds
    fg       = "#3d2b5a",  -- fg1: default fg
    fg_light = "#302b5d",  -- fg0
    fg_dim   = "#643f61",  -- fg2: statusline, brackets, operators
    fg_dark  = "#824d5b",  -- fg3: line numbers, fold column
    comment  = "#837a72",

    -- colors (base)
    black   = "#352c24",
    red     = "#a5222f",
    green   = "#396847",
    yellow  = "#ac5402",
    blue    = "#2848a9",
    magenta = "#6e33ce",
    cyan    = "#287980",
    orange  = "#955f61",
    pink    = "#a440b5",

    -- emphatic variants: darker (light theme = less lightness = more visible)
    red_e     = "#8c1d28",
    green_e   = "#30583c",
    yellow_e  = "#924702",
    blue_e    = "#223d90",
    magenta_e = "#5d2baf",
    cyan_e    = "#22676d",
    orange_e  = "#7f5152",
    pink_e    = "#8b369a",

    -- subtle variants: lighter (more lightness = less visible on light bg)
    red_s     = "#b2434e",
    green_s   = "#577f62",
    yellow_s  = "#b86e28",
    blue_s    = "#4863b6",
    magenta_s = "#8452d5",
    cyan_s    = "#488d93",
    orange_s  = "#a57779",
    pink_s    = "#b25dc0",

    -- diff backgrounds (bg blended toward color at 0.2)
    diff_add    = "#d0d6cd",
    diff_delete = "#e6c8c8",
    diff_change = "#cdd0e0",
    diff_text   = "#a4aed2",

    -- diagnostic backgrounds (bg blended toward diag color at 0.3)
    diag_error = "#deb4b5",
    diag_warn  = "#e0c2a7",
    diag_info  = "#b8bfd9",
    diag_hint  = "#bec9bc",
  }
end

local bold = false
local italic = false
local underline = true
local undercurl = true
local strikethrough = true

for name, attrs in pairs {
  ---- :help highlight-default -----------------------------------------------

  Normal = { fg = p.fg, bg = p.bg },
  NormalFloat = { bg = p.bg_float },
  FloatTitle = { fg = p.yellow, bg = p.bg_float },
  FloatFooter = { fg = p.yellow, bg = p.bg_float },

  ColorColumn = { bg = p.bg_hl },
  CursorColumn = 'LineNr',
  CursorLine = 'LineNr',
  WinSeparator = { fg = p.conceal },

  LineNr = { bg = p.bg_float },
  CursorLineNr = { fg = p.fg_dark, bg = p.bg_float },

  Folded = { fg = p.comment, bg = p.bg_hl },
  FoldColumn = 'LineNr',
  SignColumn = 'LineNr',

  Pmenu = 'NormalFloat',
  PmenuSel = { bg = p.bg_vis },
  PmenuThumb = 'PmenuSel',
  PmenuMatch = { fg = p.yellow, bold = bold },
  PmenuMatchSel = { reverse = true },
  ComplMatchIns = { fg = p.fg_dim },
  WildMenu = 'NormalFloat',

  StatusLine = 'NormalFloat',
  StatusLineNC = { fg = p.comment, bg = p.bg_float },
  TabLine = 'StatusLineNC',
  TabLineFill = 'StatusLine',
  TabLineSel = { bg = p.bg_float, bold = bold },

  CurSearch = { fg = p.bg, bg = p.yellow, bold = bold },
  MatchParen = 'Substitute',
  Search = { fg = p.bg, bg = p.bg_search, bold = bold },
  Substitute = { bg = p.diff_delete, bold = bold },
  Visual = { bg = p.bg_vis },

  Conceal = { fg = p.comment },
  Whitespace = { fg = p.bg_vis },
  EndOfBuffer = { fg = p.conceal },
  NonText = 'Whitespace',
  SpecialKey = 'Whitespace',

  Directory = { fg = p.green },
  Title = { fg = p.yellow, bold = bold },
  ErrorMsg = { bg = p.diff_delete },
  ModeMsg = { fg = p.comment },
  MoreMsg = { fg = p.green, bold = bold },
  WarningMsg = { fg = p.orange },
  Question = 'MoreMsg',

  QuickFixLine = 'PmenuMatch',
  qfFileName = 'Directory',

  ---- :help :diff -----------------------------------------------------------

  DiffAdd = { bg = p.diff_add },
  DiffChange = { bg = p.diff_change },
  DiffDelete = { fg = p.comment, bg = p.diff_delete },
  DiffText = { bg = p.diff_text },

  DiffAdded = 'DiffAdd',
  DiffRemoved = 'DiffDelete',

  ---- :help spell -----------------------------------------------------------

  SpellBad = { fg = p.red, undercurl = undercurl },
  SpellCap = { fg = p.blue, undercurl = undercurl },
  SpellLocal = { fg = p.yellow, undercurl = undercurl },
  SpellRare = { fg = p.yellow_e, undercurl = undercurl },

  ---- :help group-name ------------------------------------------------------

  Comment = { fg = p.comment, italic = italic },
  Identifier = { fg = p.fg },
  Function = { fg = p.blue_e },     -- blue emphatic (bright in dark / dim in light)
  Constant = { fg = p.orange_e },   -- orange emphatic
  String = { fg = p.green, italic = italic },
  Character = { fg = p.cyan },
  Number = { fg = p.orange },
  Boolean = 'Number',

  Statement = { fg = p.magenta },
  Operator = { fg = p.fg_dim },

  PreProc = { fg = p.pink_e },      -- pink emphatic

  Type = { fg = p.yellow },

  Special = { fg = p.cyan_e },      -- cyan emphatic (builtins)
  SpecialChar = { fg = p.orange_e },
  Delimiter = { fg = p.fg_dim },

  Underlined = { underline = underline },
  Bold = { bold = bold },
  Italic = { italic = italic },

  Ignore = { fg = p.conceal },
  Error = { bg = p.diff_delete },
  Todo = { fg = p.comment, bold = bold },

  ---- :help treesitter-highlight-groups -------------------------------------

  ['@variable'] = 'Identifier',
  ['@variable.builtin'] = '@string.special.symbol',

  ['@constant'] = 'Identifier',
  ['@constant.builtin'] = 'Constant',
  ['@constant.macro'] = 'Constant',

  ['@module'] = 'Identifier',
  ['@module.builtin'] = '@module',
  ['@label'] = { fg = p.cyan_e },

  ['@string.documentation'] = { fg = p.green, nocombine = true },
  ['@string.escape'] = { fg = p.cyan },
  ['@string.regexp'] = { fg = p.yellow_e },
  ['@string.special'] = { fg = p.cyan_e },
  ['@string.special.symbol'] = { fg = p.fg, italic = italic },
  ['@string.special.path'] = 'Directory',
  ['@string.special.url'] = { fg = p.cyan },

  ['@type.builtin'] = '@type',

  ['@function.builtin'] = '@function',
  ['@function.macro'] = '@function',
  ['@constructor'] = '@function',

  ['@keyword.function'] = 'PreProc',
  ['@keyword.import'] = 'PreProc',
  ['@keyword.directive'] = 'PreProc',

  ['@punctuation.delimiter'] = { fg = p.red_s },

  ['@comment.documentation'] = { fg = p.comment, nocombine = true },
  ['@comment.error'] = 'Todo',
  ['@comment.note'] = 'Todo',
  ['@comment.todo'] = 'Todo',
  ['@comment.warning'] = 'Todo',

  ['@markup.italic'] = { italic = italic },
  ['@markup.strong'] = { bold = bold },
  ['@markup.strikethrough'] = { strikethrough = strikethrough },
  ['@markup.underline'] = { underline = underline },

  ['@markup.heading'] = 'Title',
  ['@markup.heading.2'] = { fg = p.yellow_e, bold = bold },
  ['@markup.heading.3'] = { fg = p.green, bold = bold },
  ['@markup.heading.5'] = '@markup.heading.2',
  ['@markup.heading.6'] = '@markup.heading.3',

  ['@markup.quote'] = 'Comment',
  ['@markup.math'] = '@markup.raw',

  ['@markup.link'] = { underline = underline },
  ['@markup.link.url'] = '@string.special.url',

  ['@markup.raw'] = '@string.special',
  ['@markup.raw.block'] = { fg = p.comment },

  ['@markup.list'] = 'Delimiter',

  ['@diff.plus'] = 'DiffAdd',
  ['@diff.minus'] = 'DiffDelete',
  ['@diff.delta'] = 'DiffChange',

  ['@tag.attribute'] = '@label',
  ['@tag.delimiter'] = 'Delimiter',

  ---- :help diagnostic-highlight --------------------------------------------

  DiagnosticError = { fg = p.red },
  DiagnosticWarn = { fg = p.yellow },
  DiagnosticInfo = { fg = p.blue },
  DiagnosticHint = { fg = p.cyan },
  DiagnosticOk = { fg = p.green },
  DiagnosticUnderlineError = { undercurl = undercurl, sp = p.red },
  DiagnosticUnderlineWarn = { undercurl = undercurl, sp = p.yellow },
  DiagnosticUnderlineInfo = { undercurl = undercurl, sp = p.blue },
  DiagnosticUnderlineHint = { undercurl = undercurl, sp = p.cyan },
  DiagnosticUnderlineOk = { undercurl = undercurl, sp = p.green },

  DiagnosticDeprecated = 'DiagnosticUnderlineError',
  DiagnosticUnnecessary = { undercurl = undercurl, sp = p.comment },

  ---- :help lsp-highlight ---------------------------------------------------

  LspReferenceText = { bg = p.bg_float, underline = underline },

  ['@lsp.type.enumMember'] = 'Constant',
  ['@lsp.type.macro'] = {},
  ['@lsp.type.namespace'] = 'Directory',
  ['@lsp.type.parameter'] = { fg = p.fg, bold = bold },

  ['@lsp.typemod.comment.documentation'] = '@comment.documentation',
  ['@lsp.typemod.variable.globalScope'] = { italic = italic },

  ---- netrw -----------------------------------------------------------------

  netrwClassify = 'Delimiter',
  netrwTreeBar = 'Delimiter',
  netrwExe = { fg = p.red },
  netrwSymLink = { fg = p.magenta },

  ---- Markdown --------------------------------------------------------------

  markdownCode = '@markup.raw',
  markdownCodeBlock = '@markup.raw.block',

  ---- "lervag/vimtex" :h vimtex-syntax-reference ---------------------------

  texOptSep = '@punctuation.delimiter',
  texOptEqual = 'Operator',
  texFileArg = 'Constant',
  texTitleArg = { bold = bold },
  texRefArg = 'Constant',
  texMathZone = '@markup.math',
  texMathDelimZone = 'Statement',
  texMathEnvArgName = 'texEnvArgName',
  texMathCmd = 'Function',
  texMathDelim = 'Delimiter',
  texMathSymbol = 'Operator',
  texItemLabelConcealed = '@label',

  ---- "echasnovski/mini.nvim" -----------------------------------------------

  MiniDepsChangeAdded = { link = 'DiffAdd' },
  MiniDepsChangeRemoved = { link = 'DiffDelete' },

  MiniDiffSignAdd = { fg = p.green },
  MiniDiffSignChange = { fg = p.magenta },
  MiniDiffSignDelete = { fg = p.red },

  MiniFilesCursorLine = 'PmenuSel',
  MiniFilesTitle = { fg = p.comment, bg = p.bg_float },

  MiniIconsAzure = { fg = p.blue_e },
  MiniIconsBlue = { fg = p.blue },
  MiniIconsCyan = { fg = p.cyan },
  MiniIconsGreen = { fg = p.green },
  MiniIconsGrey = { fg = p.fg },
  MiniIconsOrange = { fg = p.orange },
  MiniIconsPurple = { fg = p.magenta },
  MiniIconsRed = { fg = p.red },
  MiniIconsYellow = { fg = p.yellow },

  MiniIndentscopeSymbol = { fg = p.bg_vis, nocombine = true },

  MiniJump2dSpot = { fg = p.magenta_e, bold = true, nocombine = true },
  MiniJump2dSpotAhead = { fg = p.cyan_e, bg = p.bg_float, nocombine = true },

  MiniPickIconDirectory = { fg = p.cyan_e },
  MiniPickMatchCurrent = { bg = p.bg_vis },
  MiniPickPrompt = { fg = p.yellow, bg = p.bg_float },

  MiniStarterFooter = { fg = p.yellow },
  MiniStarterItemPrefix = { fg = p.red },
  MiniStarterSection = { fg = p.green },
  MiniStarterQuery = { fg = p.blue },

  MiniStatuslineDevinfo = { fg = p.fg, bg = p.bg_vis },
  MiniStatuslineFileinfo = 'MiniStatuslineDevinfo',
  MiniStatuslineFilename = { fg = p.comment, bg = p.bg_float },
  MiniStatuslineModeNormal = { bg = p.comment, fg = p.bg, bold = bold },
  MiniStatuslineModeInsert = { bg = p.yellow, fg = p.bg, bold = bold },
  MiniStatuslineModeReplace = { bg = p.red, fg = p.bg, bold = bold },
  MiniStatuslineModeCommand = { bg = p.cyan, fg = p.bg, bold = bold },
  MiniStatuslineModeOther = { bg = p.green, fg = p.bg, bold = bold },
  MiniStatuslineModeVisual = { bg = p.magenta, fg = p.bg, bold = bold },

  MiniTablineFill = { link = 'TabLineFill' },

  MiniTestFail = { fg = p.red, bold = true },
  MiniTestPass = { fg = p.green, bold = true },

  MiniTrailspace = { link = 'DiffRemoved' },

  ---- "Saghen/blink.cmp" ----------------------------------------------------

  BlinkCmpLabelMatch = { fg = p.yellow, bold = bold },
  BlinkCmpKindText = '@text',
  BlinkCmpKindMethod = '@method',
  BlinkCmpKindFunction = '@function',
  BlinkCmpKindConstructor = '@constructor',
  BlinkCmpKindField = '@field',
  BlinkCmpKindVariable = '@variable',
  BlinkCmpKindClass = '@type',
  BlinkCmpKindInterface = '@type',
  BlinkCmpKindModule = '@namespace',
  BlinkCmpKindProperty = '@property',
  BlinkCmpKindUnit = '@constant',
  BlinkCmpKindValue = '@constant',
  BlinkCmpKindEnum = '@field',
  BlinkCmpKindKeyword = '@keyword',
  BlinkCmpKindSnippet = '@string.special',
  BlinkCmpKindColor = '@constant',
  BlinkCmpKindFile = '@string.special.path',
  BlinkCmpKindReference = '@type',
  BlinkCmpKindFolder = '@string.special.path',
  BlinkCmpKindEnumMember = '@field',
  BlinkCmpKindConstant = '@constant',
  BlinkCmpKindStruct = '@type',
  BlinkCmpKindEvent = '@type',
  BlinkCmpKindOperator = '@operator',
  BlinkCmpKindTypeParameter = '@type',

  ---- "hrsh7th/nvim-cmp" ----------------------------------------------------

  CmpItemAbbrMatch = { fg = p.yellow, bold = bold },
  CmpItemAbbrMatchFuzzy = { fg = p.yellow, bold = bold },
  CmpItemKindVariable = '@variable',
  CmpItemKindValue = '@constant',
  CmpItemKindUnit = '@constant',
  CmpItemKindTypeParameter = '@type',
  CmpItemKindText = '@text',
  CmpItemKindStruct = '@type',
  CmpItemKindSnippet = '@string.special',
  CmpItemKindReference = '@type',
  CmpItemKindProperty = '@property',
  CmpItemKindOperator = '@operator',
  CmpItemKindModule = '@namespace',
  CmpItemKindMethod = '@method',
  CmpItemKindKeyword = '@keyword',
  CmpItemKindInterface = '@type',
  CmpItemKindFunction = '@function',
  CmpItemKindFolder = '@string.special.path',
  CmpItemKindFile = '@string.special.path',
  CmpItemKindField = '@field',
  CmpItemKindEvent = '@type',
  CmpItemKindEnumMember = '@field',
  CmpItemKindEnum = '@type',
  CmpItemKindConstructor = '@constructor',
  CmpItemKindConstant = '@constant',
  CmpItemKindColor = '@constant',
  CmpItemKindClass = '@type',

  ---- "lewis6991/gitsigns.nvim" ---------------------------------------------

  GitSignsAdd = 'MiniDiffSignAdd',
  GitSignsChange = 'MiniDiffSignChange',
  GitSignsDelete = 'MiniDiffSignDelete',
  GitSignsCurrentLineBlame = { fg = p.blue },

  ---- "lukas-reineke/indent-blankline.nvim" ---------------------------------

  IblIndent = 'MiniIndentscopeSymbol',
  IblWhitespace = 'IblIndent',

  ---- "nvim-neo-tree/neo-tree.nvim" -----------------------------------------

  NeoTreeFloatBorder = 'Normal',
  NeoTreeNormal = 'Pmenu',
  NeoTreeNormalNC = 'NeoTreeNormal',
  NeoTreeCursorLine = 'PmenuSel',
  NeoTreeWinSeparator = { fg = p.bg, bg = p.bg },

  ---- "hiphish/rainbow-delimiters.nvim" -------------------------------------

  RainbowDelimiterRed = { fg = p.red },
  RainbowDelimiterYellow = { fg = p.yellow },
  RainbowDelimiterBlue = { fg = p.blue },
  RainbowDelimiterOrange = { fg = p.orange },
  RainbowDelimiterGreen = { fg = p.green },
  RainbowDelimiterViolet = { fg = p.magenta },
  RainbowDelimiterCyan = { fg = p.cyan },

  ---- "ibhagwan/fzf-lua" ----------------------------------------------------

  FzfLuaPathLineNr = { fg = p.red },
  FzfLuaBufNr = { fg = p.blue },
  FzfLuaLivePrompt = 'Normal',

  ---- "akinsho/bufferline.nvim" ---------------------------------------------

  BufferLineTab = 'BufferLineBuffer',
  BufferLineTabSelected = 'BufferLineBufferSelected',

} do
  if type(attrs) == 'table' then
    vim.api.nvim_set_hl(0, name, attrs)
  else
    vim.api.nvim_set_hl(0, name, { link = attrs })
  end
end

-- Terminal colors — matched to kitty dayfox/nordfox theme files.
-- Nordfox: all values are exact palette hex values.
-- Dayfox: color4/12 (blue) differ from the palette (#286983/#2d81a3 vs #2848a9);
--         the terminal blue is a hand-tuned cyan-leaning value in the kitty conf.
if vim.opt.background:get() == "dark" then
  vim.g.terminal_color_0  = "#3b4252"  -- black
  vim.g.terminal_color_1  = "#bf616a"  -- red
  vim.g.terminal_color_2  = "#a3be8c"  -- green
  vim.g.terminal_color_3  = "#ebcb8b"  -- yellow
  vim.g.terminal_color_4  = "#81a1c1"  -- blue
  vim.g.terminal_color_5  = "#b48ead"  -- magenta
  vim.g.terminal_color_6  = "#88c0d0"  -- cyan
  vim.g.terminal_color_7  = "#e5e9f0"  -- white
  vim.g.terminal_color_8  = "#465780"  -- black bright
  vim.g.terminal_color_9  = "#d06f79"  -- red bright
  vim.g.terminal_color_10 = "#b1d196"  -- green bright
  vim.g.terminal_color_11 = "#f0d399"  -- yellow bright
  vim.g.terminal_color_12 = "#8cafd2"  -- blue bright
  vim.g.terminal_color_13 = "#c895bf"  -- magenta bright
  vim.g.terminal_color_14 = "#93ccdc"  -- cyan bright
  vim.g.terminal_color_15 = "#e7ecf4"  -- white bright
else
  vim.g.terminal_color_0  = "#352c24"  -- black
  vim.g.terminal_color_1  = "#a5222f"  -- red
  vim.g.terminal_color_2  = "#396847"  -- green
  vim.g.terminal_color_3  = "#ac5402"  -- yellow
  vim.g.terminal_color_4  = "#286983"  -- blue (terminal-tuned, differs from palette #2848a9)
  vim.g.terminal_color_5  = "#6e33ce"  -- magenta
  vim.g.terminal_color_6  = "#287980"  -- cyan
  vim.g.terminal_color_7  = "#f2e9e1"  -- white
  vim.g.terminal_color_8  = "#534c45"  -- black bright
  vim.g.terminal_color_9  = "#b3434e"  -- red bright
  vim.g.terminal_color_10 = "#577f63"  -- green bright
  vim.g.terminal_color_11 = "#b86e28"  -- yellow bright
  vim.g.terminal_color_12 = "#2d81a3"  -- blue bright (terminal-tuned, differs from palette #4863b6)
  vim.g.terminal_color_13 = "#8452d5"  -- magenta bright
  vim.g.terminal_color_14 = "#488d93"  -- cyan bright
  vim.g.terminal_color_15 = "#f4ece6"  -- white bright
end

-- vi:nowrap
