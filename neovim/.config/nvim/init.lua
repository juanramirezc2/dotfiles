-- nvim lazy config ---- {{{{{{{{{{{{{{{{{{{{{{{{{{{
-- This file is automatically loaded by plugins.config
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
-- }}}}}}}}}}}}}}}}}}}}}}}}}}}
-- local env = vim.env
local utils = require("utils")
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local o = vim.o
-- local nmap = utils.nmap
-- local vmap = utils.vmap
local imap = utils.imap
-- local xmap = utils.xmap
-- local omap = utils.omap
local inoremap = utils.inoremap
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap

-- Global Configs
-- o.background = 'light'
--Make line numbers default
vim.wo.number       = true
vim.o.filetype      = true
--Enable mouse mode
vim.o.mouse         = 'a'
vim.o.scrolloff     = 12 -- Vertical Scroll Offset
vim.o.sidescrolloff = 8 -- Horizontal Scroll Offset
vim.o.mouse         = 'a' -- Enable mouse mode
--Enable break indent
vim.o.breakindent   = true
vim.o.splitbelow    = true -- Force Split Below
vim.o.splitright    = true -- Force Split Right
-- Enable cursor line
-- vim.wo.cursorline   = true
vim.o.jumpoptions   = "stack"
o.foldlevelstart    = 99
o.autoindent        = true
o.smartindent       = true
--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase    = true
vim.o.smartcase     = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Core mappings changed
inoremap("jk", "<Esc>")
nnoremap("<C-h>", "^")
vnoremap("<C-h>", "^")
nnoremap("<C-l>", "g_")
vnoremap("<C-l>", "g_")
nnoremap("<leader><CR>", ":nohlsearch<CR>")

-- Copy to clipboard
vnoremap("<C-c>", '"*y')
nnoremap("<C-c>", '"*y')

vnoremap('<C-v>', '"*p')
nnoremap("<C-v>", '"*p')

vnoremap('<C-x>', '"+d')
nnoremap('<C-x>', '"+d')
-- replace without deleting in visual
vnoremap("<leader>p", [["_dp]])
-- Search Selection
vnoremap("//", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]])
-- Switch to alternative buffer
nnoremap("<leader><tab>", "<C-^>")

nnoremap("<leader>vr", ':e $MYVIMRC<CR>')
-- plugin configs
-- local plugins = require("plugins")
require("plugins-lite")
