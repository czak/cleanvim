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
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

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

-- Config quick reload
vim.keymap.set("n", "<leader>cr", "<cmd>so %<CR>", { desc = "Source config file" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>ss', builtin.pickers, { desc = 'Telescope live grep' })

-- nvim-tree
vim.keymap.set('n', '\\', "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })


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

require("nvim-tree").setup()


-- vim: ts=2 sts=2 sw=2 et
