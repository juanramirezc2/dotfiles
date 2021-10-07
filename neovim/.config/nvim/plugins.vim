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
Plug 'Valloric/MatchTagAlways' "highlight tags for easy html
Plug 'Yggdroot/indentLine'
"File browsers
Plug 'tpope/vim-projectionist' ""
"Git helpers
Plug 'rhysd/git-messenger.vim'  "Neovim plugin to reveal the commit messages under the cursor
Plug 'tpope/vim-fugitive'  " git on vim
"syntax highlighting files {{{
"Custom vim Text Objects
Plug 'kana/vim-textobj-user'  "vim-textobj-user - Create your own text objects for vim in an easy way
Plug 'jlanzarotta/bufexplorer'
Plug 'maxbrunsfeld/vim-yankstack' "A lightweight implementation of emacs's kill-ring for vim
" moving around
Plug 'easymotion/vim-easymotion'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"file icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
"lua line
Plug 'hoob3rt/lualine.nvim'
"themes
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'tomasiser/vim-code-dark'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'mhartington/oceanic-next'
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'NLKNguyen/papercolor-theme'
Plug 'cocopon/iceberg.vim'
call plug#end()
