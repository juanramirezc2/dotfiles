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
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'jceb/vim-orgmode' "Org mode in vim
Plug 'scrooloose/nerdcommenter' " comment lines of code using this plugin
Plug 'alvan/vim-closetag' "Auto close (X)HTML tags
Plug 'tpope/vim-surround' "surround plugin
Plug 'andymass/vim-matchup' "jumping between opening and closing symbols
"}}}
"GUI customization
Plug 'Valloric/MatchTagAlways' "highlight tags for easy html 
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline' " indent guides lines let's see how they goes
Plug 'vim-airline/vim-airline-themes'  " indent guides lines let's see how they goes
"File browsers
Plug 'preservim/nerdtree' "file browsing panel
Plug 'Shougo/denite.nvim'  "Denite is a dark powered plugin for Neovim/Vim to unite all interfaces.
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neomru.vim' " MRU plugin includes unite.vim/denite.nvim MRU sources Most Recent Used
"Git helpers
Plug 'rhysd/git-messenger.vim'  "Neovim plugin to reveal the commit messages under the cursor
Plug 'tpope/vim-fugitive'  " git on vim
Plug 'xuyuanp/nerdtree-git-plugin'  "nerd tree git status
Plug 'jiangmiao/auto-pairs'  " automaticamente cierra comillas o llaves
" syntax highlighting files {{{
" colorize hexa
Plug 'norcalli/nvim-colorizer.lua'
"javascript
Plug 'othree/yajs.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'liuchengxu/vista.vim' "View and search LSP symbols, tags in Vim/NeoVim.
Plug 'heavenshell/vim-jsdoc'
" markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
"}}}
" ultisnips snippets
Plug 'epilande/vim-es2015-snippets'  " Custom ultisnippets for ES2015 and vim
Plug 'epilande/vim-react-snippets'  "Custom ultisnippets for react and vim
" Custom vim Text Objects
Plug 'kana/vim-textobj-user'  "vim-textobj-user - Create your own text objects for vim in an easy way
Plug 'michaeljsmith/vim-indent-object'  " blocks of indentation as vim text objects
Plug 'wellle/targets.vim'  "Vim plugin that provides additional text objects
Plug 'kana/vim-textobj-line'  "Text objects for the current line
Plug 'kana/vim-textobj-entire'  "entire file as vim object
" other plugins
Plug 'rbgrouleff/bclose.vim' "The BClose Vim plugin for deleting a buffer without closing the window
"Plug 'luochen1990/rainbow' "Rainbow Parentheses Improved, shorter code, no level limit, smooth
Plug 'mattn/vim-gist' "The BClose Vim plugin for deleting a buffer without closing the window
Plug 'maxbrunsfeld/vim-yankstack' "A lightweight implementation of emacs's kill-ring for vim
Plug 'ntpeters/vim-better-whitespace'  "Vim Better Whitespace Plugin
Plug 'machakann/vim-highlightedyank'  "highlight yanked text
Plug 'vimwiki/vimwiki'  "VimWiki is a personal wiki for Vim -- a number of linked text files that have their own syntax highlighting.
" file icons
Plug 'junegunn/vim-easy-align'  "A Vim alignment plugin
Plug 'ryanoasis/vim-devicons'  " vim will become visual studio
"" vim prettier
Plug 'sbdchd/neoformat'
" key mappings
Plug 'tpope/vim-unimpaired'  "Pairs of handy bracket mappings
" themes
Plug 'morhetz/gruvbox'
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
call plug#end()
