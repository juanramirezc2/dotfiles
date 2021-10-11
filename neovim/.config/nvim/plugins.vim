" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
"startup and sessions managers
Plug 'mhinz/vim-startify' "bellisima y magnifica primera pantalla para vim
"Code helpers {{{
" Or build from source code by using yarn: https://yarnpkg.com
Plug 'scrooloose/nerdcommenter' " comment lines of code using this plugin
Plug 'alvan/vim-closetag' "Auto close (X)HTML tags
Plug 'machakann/vim-sandwich' "surround plugin
Plug 'andymass/vim-matchup' "jumping between opening and closing symbols
Plug 'vim-test/vim-test' "test runner
Plug 'jiangmiao/auto-pairs'  " automaticamente cierra comillas o llaves
"}}}
" Control Tmux from within vim
"GUI customization
Plug 'Yggdroot/indentLine'
"File browsers
Plug 'tpope/vim-projectionist' ""
"Git helpers
Plug 'rhysd/git-messenger.vim'  "Neovim plugin to reveal the commit messages under the cursor
Plug 'tpope/vim-fugitive'  " git on vim
"syntax highlighting files {{{
"Custom vim Text Objects
Plug 'jlanzarotta/bufexplorer'
Plug 'maxbrunsfeld/vim-yankstack' "A lightweight implementation of emacs's kill-ring for vim
" key mappings
Plug 'tpope/vim-unimpaired'  "Pairs of handy bracket mappings
" others
Plug 'chaoren/vim-wordmotion' "Word motion
Plug 'rhysd/clever-f.vim' "Clever F
"LSP config 
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip user.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" For ultisnips user.
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' "vim-snippets
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'wellle/targets.vim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"file icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
"lua line
Plug 'nvim-lua/lsp-status.nvim' "This is a Neovim plugin/library for generating statusline components
Plug 'hoob3rt/lualine.nvim'
"highlight yanked text
Plug 'machakann/vim-highlightedyank'
" A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
"Plug 'glepnir/lspsaga.nvim'
Plug 'sunjon/shade.nvim' "Neovim plugin that dims your inactive windows
Plug 'folke/twilight.nvim' "dims inactive portions of the code you're editing
"themes
Plug 'morhetz/gruvbox'
"with trigger
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } "Telescope Native sorter
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()
