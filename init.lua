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
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = true
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
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0


-- ----------------------------------------
-- Keymaps
-- ----------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- Navigate diagnostics with floating window
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

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
  ":silent !tmux popup -d <C-r>=getcwd()<cr> -w 100\\% -h 100\\% -E lazygit<cr>",
  { desc = "Lazygit" }
)

-- Buffer management
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Config file
vim.keymap.set("n", "<leader>ce", ":e $MYVIMRC<CR>", { desc = "Edit config file" })
vim.keymap.set("n", "<leader>cr", ":luafile $MYVIMRC<CR>", { desc = "Source config file" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.git_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Telescope live grep' })

-- nvim-tree
vim.keymap.set('n', '\\', "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })

-- HACK: Disable vim-ruby binding which interferes with LSP and tagfunc handling
vim.keymap.set("n", "<C-]>", "<C-]>")


-- ----------------------------------------
-- LSP and diagnostics
-- ----------------------------------------

-- Enable verbose log from lsp:
-- vim.lsp.set_log_level 'trace'
-- require('vim.lsp.log').set_format_func(vim.inspect)
--
-- Then open log with:
-- :lua vim.cmd('tabnew ' .. vim.lsp.get_log_path())

vim.lsp.enable({
  "lua_ls",
  "rubocop",
  "ruby_lsp",
  "tailwindcss",
  "vtsls",
})

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "none", source = "if_many" },
  underline = true,
  virtual_text = false,
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
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.95, height = 0.95 },
    },
    mappings = {
      i = {
        ["<Esc>"] = telescope_actions.close,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = telescope_actions.delete_buffer + telescope_actions.move_to_top,
        }
      }
    }
  }
})

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
    vim.keymap.set("n", "<C-t>",          api.node.open.tab,                  opts("Open: New Tab"))
    vim.keymap.set("n", "<C-v>",          api.node.open.vertical,             opts("Open: Vertical Split"))
    vim.keymap.set("n", "<C-x>",          api.node.open.horizontal,           opts("Open: Horizontal Split"))
    vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,     opts("Close Directory"))
    vim.keymap.set("n", "<CR>",           api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("Up"))
    vim.keymap.set("n", "a",              api.fs.create,                      opts("Create File Or Directory"))
    vim.keymap.set("n", "c",              api.fs.copy.node,                   opts("Copy"))
    vim.keymap.set("n", "d",              api.fs.remove,                      opts("Delete"))
    vim.keymap.set("n", "E",              api.tree.expand_all,                opts("Expand All"))
    vim.keymap.set("n", "F",              api.live_filter.clear,              opts("Live Filter: Clear"))
    vim.keymap.set("n", "f",              api.live_filter.start,              opts("Live Filter: Start"))
    vim.keymap.set("n", "g?",             api.tree.toggle_help,               opts("Help"))
    vim.keymap.set("n", "h",              api.node.navigate.parent_close,     opts("Close Directory"))
    vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
    vim.keymap.set("n", "I",              api.tree.toggle_gitignore_filter,   opts("Toggle Filter: Git Ignore"))
    vim.keymap.set("n", "K",              api.node.show_info_popup,           opts("Info"))
    vim.keymap.set("n", "l",              api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "o",              api.node.open.edit,                 opts("Open"))
    -- vim.keymap.set("n", "o",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
    vim.keymap.set("n", "p",              api.fs.paste,                       opts("Paste"))
    vim.keymap.set("n", "q",              api.tree.close,                     opts("Close"))
    -- vim.keymap.set("n", "r",              api.fs.rename,                      opts("Rename"))
    vim.keymap.set("n", "r",              api.fs.rename_full,                 opts("Rename"))
    vim.keymap.set("n", "R",              api.tree.reload,                    opts("Refresh"))
    vim.keymap.set("n", "W",              api.tree.collapse_all,              opts("Collapse All"))
    vim.keymap.set("n", "x",              api.fs.cut,                         opts("Cut"))
    vim.keymap.set("n", "<2-LeftMouse>",  api.node.open.edit,                 opts("Open"))
  end,
})
