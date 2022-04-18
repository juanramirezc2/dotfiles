-- local env = vim.env
local utils = require("utils")
local fn = vim.fn
local opt = vim.opt
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
-- Set colorscheme
g.gruvbox_contrast_dark = 'soft'
-- o.background = 'light'
cmd [[colorscheme gruvbox]]
--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

vim.opt.expandtab = true
vim.opt.tabstop =  2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.o.scrolloff       = 12  	  -- Vertical Scroll Offset
vim.o.sidescrolloff   = 8  	    -- Horizontal Scroll Offset
vim.o.mouse           = 'a'	    -- Enable mouse mode
--Enable break indent
vim.o.breakindent = true
vim.o.splitbelow      = true 	-- Force Split Below
vim.o.splitright      = true 	-- Force Split Right
-- Enable cursor line
vim.wo.cursorline = true

--Save undo history
vim.opt.undofile = true
-- don't use backup files
opt.backup = false 
-- don't backup the file while editing
opt.writebackup = false 
-- don't create swap files for new buffers
opt.swapfile = false 
o.foldlevelstart = 99
o.autoindent = true
o.smartindent = true
--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Core mappings changed
inoremap("jk","<Esc>")
nnoremap("<C-h>", "^")
vnoremap("<C-h>", "^")
nnoremap("<C-l>", "g_")
vnoremap("<C-l>", "g_")
nnoremap("<C-j>", "<c-d>")
vnoremap("<C-j>", "<c-d>")
nnoremap("<C-k>", "<c-u>")
vnoremap("<C-k>", "<c-u>")
nnoremap("<leader><CR>", ":nohlsearch<CR>")

-- Copy to clipboard
vnoremap("<C-c>", '"*y')
nnoremap("<C-c>", '"*y')

vnoremap('<C-v>', '"*p')
nnoremap("<C-v>", '"*p')

vnoremap('<C-x>', '"+d')
nnoremap('<C-x>', '"+d')

-- Search Selection
vnoremap("//", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]])
-- Switch to alternative buffer
nnoremap("<leader><tab>", "<C-^>")
--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- plugin configs
local plugins = require("plugins")
