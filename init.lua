-- ----------------------------------------
-- Colorscheme
-- ----------------------------------------

vim.cmd.colorscheme("melange")


-- ----------------------------------------
-- Options
-- ----------------------------------------

-- User interface
vim.opt.number = false
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25"
vim.opt.termguicolors = true

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevel = 99

-- Display invisible chars (I only really want trailing space)
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = "~" }

-- Text editing and behavior
vim.opt.clipboard:append("unnamedplus")
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.confirm = true
vim.opt.path:append("**")

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- Performance and timing
vim.opt.updatetime = 250

-- Enable per-project configuration files (.nvimrc, .nvim.lua)
vim.opt.exrc = true

-- Completion & popup styles
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.winborder = "single"


-- ----------------------------------------
-- Filetype tweaks
-- ----------------------------------------

vim.filetype.add({
  extension = {
    jbuilder = 'ruby',
  },
})


-- ----------------------------------------
-- Keymaps
-- ----------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Prevent vim-ruby from setting custom mappings
-- (mostly due to conflicting <C-]> mapping)
vim.g.no_ruby_maps = true

-- Navigate visual lines instead of logical lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

-- Gotta go fast
vim.keymap.set({ "n", "v" }, "<C-j>", "10gj")
vim.keymap.set({ "n", "v" }, "<C-k>", "10gk")

-- Clear search highlights with esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Pasting in visual mode
vim.keymap.set("v", "p", "P")

-- Trying out a smart fold
vim.keymap.set('n', 'zm', function()
  if vim.o.foldlevel == 99 then
    vim.cmd('normal! zR')
  end
  vim.cmd('normal! zm')
end, { desc = "Fold more, resetting if maxed" })

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- Quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit application" })

-- Toggle background
vim.keymap.set("n", "<leader>tb", function()
  vim.opt.background = vim.opt.background:get() == "dark" and "light" or "dark"
end, { desc = "Toggle background" })

-- Lazygit
vim.keymap.set(
  "n",
  "<leader>gg",
  ":silent !tmux popup -d <C-r>=getcwd()<cr> -e PATH=$PATH -w 100\\% -h 100\\% -E lazygit<cr>",
  { desc = "Lazygit" }
)

-- Buffer management
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>%bd!<CR>", { desc = "Close all buffers" })
vim.keymap.set("n", "<leader>yp", ':let @+ = expand("%")<cr>', { desc = "Yank current buffer path" })

-- Config file
vim.keymap.set("n", "<leader>ce", ":e $MYVIMRC<CR>", { desc = "Edit config file" })
vim.keymap.set("n", "<leader>cr", ":luafile $MYVIMRC<CR>", { desc = "Source config file" })

-- nvim-tree
vim.keymap.set('n', '\\', "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })
vim.keymap.set('n', '|', "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in nvim-tree" })

-- Vimux
vim.keymap.set('n', '<leader>vp', "<cmd>VimuxPromptCommand<cr>", { desc = "Vimux Prompt Command" })
vim.keymap.set('n', '<leader>vl', "<cmd>VimuxRunLastCommand<cr>", { desc = "Vimux Run Last Command" })

-- Github link open/yank
vim.keymap.set('n', '<leader>gO', require('gitlinker').open)
vim.keymap.set('n', '<leader>gY', require('gitlinker').copy)

-- Tab navigation
vim.keymap.set('n', ']t', "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set('n', '[t', "<cmd>tabprevious<cr>", { desc = "Previous tab" })


-- ----------------------------------------
-- Autocommands
-- ----------------------------------------

local augroup = vim.api.nvim_create_augroup('MyConfig', { clear = true })

-- No comment continuation ever, for any language
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove('o')
  end,
})


-- ----------------------------------------
-- LSP
-- ----------------------------------------

-- Enable verbose log from lsp:
-- vim.lsp.set_log_level 'trace'
-- require('vim.lsp.log').set_format_func(vim.inspect)
--
-- Then open log with:
-- :lua vim.cmd('tabnew ' .. vim.lsp.get_log_path())

-- See capabilities for a given server, do this in an LSP-enabled buffer:
-- :lua =vim.lsp.get_clients()[1].server_capabilities

local function show_signature()
  vim.lsp.buf.signature_help({
    close_events = { "InsertLeave" },
    focusable = false,
  })
end

local function on_attach(client, bufnr)
  vim.keymap.set("i", "<C-Space>", show_signature, { buffer = true, desc = "LSP: Show signature" })

  -- Completion on server-defined trigger keys
  if client:supports_method('textDocument/completion') then
    -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    -- client.server_capabilities.completionProvider.triggerCharacters = chars
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end

  -- Auto trigger signature help
  -- if client:supports_method('textDocument/signatureHelp') then
  --   vim.api.nvim_create_autocmd('CursorHoldI', {
  --     buffer = bufnr,
  --     callback = show_signature,
  --   })
  -- end

  -- Auto format on save
  if client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
      end,
    })
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_attach(client, args.buf)
  end,
})

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "ruby_lsp",
  "tailwindcss",
  "vtsls",
})


-- ----------------------------------------
-- Diagnostics
-- ----------------------------------------

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "single",
    source = "if_many",
  },
  underline = true,
  virtual_text = {
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
})


-- -------------------------------------------
-- Plugin: https://github.com/ibhagwan/fzf-lua
-- -------------------------------------------

local fzflua = require('fzf-lua')

vim.keymap.set('n', '<leader><leader>', fzflua.git_files, { desc = 'fzf-lua git files' })
vim.keymap.set('n', '<leader>ff', fzflua.files, { desc = 'fzf-lua find files' })
vim.keymap.set('n', '<leader>fg', fzflua.live_grep, { desc = 'fzf-lua live grep' })
vim.keymap.set('n', '<leader>fh', fzflua.help_tags, { desc = 'fzf-lua help tags' })
vim.keymap.set('n', '<leader>fb', fzflua.buffers, { desc = 'fzf-lua buffers' })
vim.keymap.set('n', '<leader>fo', fzflua.oldfiles, { desc = 'fzf-lua oldfiles' })
vim.keymap.set('n', '<leader>fq', fzflua.quickfix, { desc = 'fzf-lua quickfix' })
vim.keymap.set('n', '<leader>fs', fzflua.builtin, { desc = 'fzf-lua builtin' })
vim.keymap.set('n', '<leader>fr', fzflua.resume, { desc = 'fzf-lua resume' })

fzflua.setup({
  winopts = {
    height = 0.95,
    width = 0.95,
    backdrop = 100,
    preview = {
      horizontal = "right:45%",
    },
  },
  fzf_colors = {
    -- true, -- inherit fzf colors that aren't specified below from
    -- the auto-generated theme similar to `fzf_colors=true`
    ["fg"]      = { "fg", "Comment" },
    ["bg"]      = { "bg", "Normal" },
    ["hl"]      = { "fg", "Operator" },
    ["fg+"]     = { "fg", "Normal" },
    ["bg+"]     = { "bg", { "CursorLine", "Normal" } },
    ["hl+"]     = { "fg", "Operator" },
    ["info"]    = { "fg", "PreProc" },
    ["prompt"]  = { "fg", "Conditional" },
    ["pointer"] = { "fg", "Exception" },
    ["marker"]  = { "fg", "Keyword" },
    ["spinner"] = { "fg", "Label" },
    ["header"]  = { "fg", "Comment" },
    ["gutter"]  = "-1",
  },
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      ["ctrl-j"] = "half-page-down",
      ["ctrl-k"] = "half-page-up",
    },
  },
  actions = {
    files = {
      ["enter"] = fzflua.actions.file_edit,
      ["ctrl-x"] = fzflua.actions.file_split,
      ["ctrl-v"] = fzflua.actions.file_vsplit,
      ["ctrl-t"] = fzflua.actions.file_tabedit,
      ["ctrl-q"] = function(selected, opts)
        opts.copen = false; fzflua.actions.file_sel_to_qf(selected, opts)
      end,
    },
  },
  buffers = {
    actions = {
      ["del"] = { fn = fzflua.actions.buf_del, reload = true },
      ["ctrl-x"] = fzflua.actions.file_split,
    }
  },
  quickfix = {
    actions = {
      ["del"] = { fn = fzflua.actions.list_del, reload = true },
      ["ctrl-x"] = fzflua.actions.file_split,
    },
  },
  blines = {
    previewer = false,
  },
  lines = {
    previewer = false,
  },
})


-- --------------------------------------------------
-- Plugin: https://github.com/nvim-tree/nvim-tree.lua
-- --------------------------------------------------

require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false,
        modified = false,
        hidden = false,
        diagnostics = false,
        bookmarks = false,
      },
    },
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- See :help nvim-tree-mappings-default
    vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
    vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
    vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
    vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
    vim.keymap.set("n", ";", function(node) api.node.open.preview(node, { focus = true }) end, opts("Preview"))
    vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
    vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
    vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
    vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
    vim.keymap.set("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
    vim.keymap.set("n", "f", api.live_filter.start, opts("Live Filter: Start"))
    vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
    vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
    vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
    -- vim.keymap.set("n", "o",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
    vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
    vim.keymap.set("n", "q", api.tree.close, opts("Close"))
    -- vim.keymap.set("n", "r",              api.fs.rename,                      opts("Rename"))
    vim.keymap.set("n", "r", api.fs.rename_full, opts("Rename"))
    vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
    vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse All"))
    vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
    vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  end,
})


-- --------------------------------------------------
-- Plugin: https://github.com/lewis6991/gitsigns.nvim
-- --------------------------------------------------

require("gitsigns").setup({
  -- See https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#-keymaps
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function opts(desc)
      return { desc = "gitsigns: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, opts("Next hunk"))

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, opts("Previous hunk"))

    -- Actions
    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, opts("Stage hunk"))
    vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, opts("Undo stage hunk"))
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, opts("Reset hunk"))

    vim.keymap.set('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, opts("Stage selection"))

    vim.keymap.set('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, opts("Reset selection"))

    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, opts("Stage buffer"))
    vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, opts("Reset buffer"))
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, opts("Preview hunk"))
    vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, opts("Preview hunk inline"))

    vim.keymap.set('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, opts("Blame line"))

    vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, opts("Diff"))

    vim.keymap.set('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end, opts("Diff ~"))

    vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist('all') end, opts("Hunks to QuickList"))
    vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, opts("Hunks to QuickList: all files"))

    -- Toggles
    vim.keymap.set('n', '<leader>tg', gitsigns.toggle_current_line_blame, opts("Toggle current line blame"))
    vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, opts("Toggle word diff"))

    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, opts("Select hunk"))
  end
})


-- ----------------------------------------------------------
-- Plugin: https://github.com/nvim-treesitter/nvim-treesitter
-- ----------------------------------------------------------

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- --------------------------------------------------
-- Plugin: https://github.com/akinsho/bufferline.nvim
-- --------------------------------------------------

require("bufferline").setup({
  options = {
    always_show_bufferline = true,
  },
})


-- ----------------------------------------------
-- Plugin: https://github.com/tiagovla/scope.nvim
-- ----------------------------------------------

require("scope").setup({})
