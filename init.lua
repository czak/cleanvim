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

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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
vim.opt.timeoutlen = 300

-- Enable per-project configuration files (.nvimrc, .nvim.lua)
vim.opt.exrc = true

-- Completion & popup styles
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.winborder = "single"


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

-- Config file
vim.keymap.set("n", "<leader>ce", ":e $MYVIMRC<CR>", { desc = "Edit config file" })
vim.keymap.set("n", "<leader>cr", ":luafile $MYVIMRC<CR>", { desc = "Source config file" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = 'Telescope oldfiles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Telescope resume' })

-- nvim-tree
vim.keymap.set('n', '\\', "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })
vim.keymap.set('n', '|', "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in nvim-tree" })

-- Vimux
vim.keymap.set('n', '<leader>vp', "<cmd>VimuxPromptCommand<cr>", { desc = "Vimux Prompt Command" })
vim.keymap.set('n', '<leader>vl', "<cmd>VimuxRunLastCommand<cr>", { desc = "Vimux Run Last Command" })


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

vim.lsp.enable({
  "gopls",
  "lua_ls",
  -- "rubocop", -- ruby_lsp invokes Rubocop too
  "ruby_lsp",
  "tailwindcss",
  "vtsls",
})

-- See https://neovim.io/doc/user/lsp.html#lsp-attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Enable auto-completion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
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


-- ----------------------------------------
-- Plugins
-- ----------------------------------------

local telescope_actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.95, height = 0.95 },
      horizontal = { width = 0.95, height = 0.95 },
    },
    mappings = {
      i = {
        ["<Esc>"] = telescope_actions.close,
        ["<C-f>"] = telescope_actions.to_fuzzy_refine,
        ["<C-q>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
        ["<C-S-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = telescope_actions.delete_buffer,
        }
      }
    }
  }
})

require('telescope').load_extension('fzf')

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

require("bufferline").setup({
  options = {
    always_show_bufferline = false,
  },
})
