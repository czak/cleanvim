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

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- local map = function(keys, func, desc, mode)
		-- 	mode = mode or "n"
		-- 	vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		-- end

    -- map("<leader>cn", vim.lsp.buf.rename, "Rename")
		-- map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
		-- map("<leader>cr", require("telescope.builtin").lsp_references, "References")
		-- map("<leader>ci", require("telescope.builtin").lsp_implementations, "Implementation")
		-- map("<leader>cd", require("telescope.builtin").lsp_definitions, "Definition")
		-- map("<leader>cD", vim.lsp.buf.declaration, "Declaration")
		-- map("<leader>co", require("telescope.builtin").lsp_document_symbols, "Document symbols")
		-- map("<leader>cw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
		-- map("<leader>ct", require("telescope.builtin").lsp_type_definitions, "Type definition")
	end,
})

-- vim: ts=2 sts=2 sw=2 et
