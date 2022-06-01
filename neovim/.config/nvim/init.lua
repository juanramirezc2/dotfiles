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
-- o.background = 'light'
--Make line numbers default
vim.wo.number = true
vim.o.filetype = true
--Enable mouse mode
vim.o.mouse = 'a'

vim.opt.expandtab = true
--vim.opt.guicursor = "guicursor=n-v-c:block,i-ci-ve:ver25, r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor, sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.tabstop =  2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.o.scrolloff       = 12  	  -- Vertical Scroll Offset
vim.o.sidescrolloff   = 8  	    -- Horizontal Scroll Offset
vim.o.mouse           = 'a'	    -- Enable mouse mode
-- Show invisible characters
vim.opt.listchars = { trail = '·', tab = [[▸\]], eol = '¬', nbsp = '_' } 
vim.opt.list = true
--Enable break indent
vim.o.breakindent = true
vim.o.splitbelow      = true 	-- Force Split Below
vim.o.splitright      = true 	-- Force Split Right
-- Enable cursor line
vim.wo.cursorline = true
vim.o.jumpoptions = "stack"
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
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
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
-- neovim terminal
vim.api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap('t', '<C-d>', [[<C-\><C-d>]], { noremap = true })
-- buffer management
nnoremap("<leader>bd", ':bdelete<cr>')
nnoremap("<leader>l", ':bnext<cr>')
nnoremap("<leader>h", ':bprevious<cr>')
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
-- local plugins = require("plugins")
local plugins = require("plugins-lite")
-- Set colorscheme
g.gruvbox_contrast_dark = 'soft'
cmd [[colorscheme gruvbox]]
