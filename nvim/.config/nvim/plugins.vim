" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
"code auto completers and helpers
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}"
call dein#add('Shougo/deoplete.nvim') "Dark powered asynchronous completion framework for neovim/Vim8
call dein#add('Shougo/deoplete-lsp') "LSP Completion source for deoplete
call dein#add('fszymanski/deoplete-emoji')
call dein#add('Shougo/echodoc.vim')
call dein#add('neovim/nvim-lsp') " lsp config for neovim lsp client
call dein#add('haorenW1025/diagnostic-nvim')
call dein#add('jceb/vim-orgmode') "Org mode in vim
call dein#add('scrooloose/nerdcommenter') " comment lines of code using this plugin
call dein#add('alvan/vim-closetag') "Auto close (X)HTML tags
call dein#add('tpope/vim-surround') "surround plugin
"startup and sessions managers
call dein#add('mhinz/vim-startify') "bellisima y magnifica primera pantalla para vim
"Moving arround
call dein#add('easymotion/vim-easymotion') "movamonos un poco mas rapidin con este easymotion
call dein#add('yuttie/comfortable-motion.vim') " smooth motions and avoid get losed scrolling
call dein#add('andymass/vim-matchup') " drop-in replacement for the vim plugin matchit.vim
call dein#add('haya14busa/incsearch.vim') " Improved incremental searching for Vim
"GUI customization
call dein#add('yggdroot/indentline') " indent guides lines let's see how they goes
call dein#add('vim-airline/vim-airline') " indent guides lines let's see how they goes
call dein#add('vim-airline/vim-airline-themes') " Temas para airline la barra en la parte baja
"File browsers
call dein#add('Shougo/denite.nvim') "Denite is a dark powered plugin for Neovim/Vim to unite all interfaces.
call dein#add('Shougo/denite.nvim') "Denite is a dark powered plugin for Neovim/Vim to unite all interfaces.
call dein#add('raghur/fruzzy', {'build': 'python3 ./python3/fruzzy_installer.py'}) "Freaky fast fuzzy Denite/CtrlP matcher for vim/neovim
call dein#add('scrooloose/nerdtree') "proyect tree and structure
"Git helpers
call dein#add('airblade/vim-gitgutter') " muestra los cambios en archivos en la parte izquierda donde estan los numeros de linea
call dein#add('rhysd/git-messenger.vim') "Neovim plugin to reveal the commit messages under the cursor
call dein#add('tpope/vim-fugitive') " git on vim
call dein#add('xuyuanp/nerdtree-git-plugin') "nerd tree git status
call dein#add('jiangmiao/auto-pairs') " automaticamente cierra comillas o llaves
" syntax files
call dein#add('sheerun/vim-polyglot') " syntax hightlight for multiple languages
"" vim snnipets
call dein#add('epilande/vim-es2015-snippets') " Custom ultisnippets for ES2015 and vim
call dein#add('epilande/vim-react-snippets') "Custom ultisnippets for react and vim
" Custom vim Text Objects
call dein#add('kana/vim-textobj-user') "vim-textobj-user - Create your own text objects for vim in an easy way
call dein#add('michaeljsmith/vim-indent-object') " blocks of indentation as vim text objects
call dein#add('wellle/targets.vim') "Vim plugin that provides additional text objects
call dein#add('kana/vim-textobj-line') "Text objects for the current line
call dein#add('kana/vim-textobj-entire') "entire file as vim object
" other plugins
call dein#add('ntpeters/vim-better-whitespace') "Vim Better Whitespace Plugin
call dein#add('machakann/vim-highlightedyank') "highlight yanked text
call dein#add('vimwiki/vimwiki') "VimWiki is a personal wiki for Vim -- a number of linked text files that have their own syntax highlighting.
" file icons
call dein#add('rhysd/clever-f.vim') "Extended f, F, t and T key mappings for Vim.
call dein#add('junegunn/vim-easy-align') "A Vim alignment plugin
call dein#add('ryanoasis/vim-devicons') " vim will become visual studio
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')  " needed for devicons
" themes
call dein#add('morhetz/gruvbox')
"" vim prettier
call dein#add('sbdchd/neoformat')  " formatting code
if dein#check_install()
  call dein#install()
endif
call dein#end()
call dein#save_state()
endif
filetype plugin indent on
