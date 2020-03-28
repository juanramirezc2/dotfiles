" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

"" Directorio de plugins
call plug#begin('~/.local/share/nvim/plugged')
" code auto completers and helpers
Plug 'heavenshell/vim-jsdoc' "jsdoc.vim generates JSDoc block comments based on a function signature
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}"
Plug 'scrooloose/nerdcommenter' " comment lines of code using this plugin
Plug 'alvan/vim-closetag' "Auto close (X)HTML tags
Plug 'tpope/vim-surround' "surround plugin
"Print function signatures in echo area
Plug 'Shougo/echodoc.vim'
"startup and sessions managers
Plug 'mhinz/vim-startify' "bellisima y magnifica primera pantalla para vim
"Moving arround
"Plug 'unblevable/quick-scope' "An always-on highlight for a unique character in every word on a line to help you use f, F and family.
Plug 'easymotion/vim-easymotion' "movamonos un poco mas rapidin con este easymotion
Plug 'yuttie/comfortable-motion.vim' " smooth motions and avoid get losed scrolling
Plug 'andymass/vim-matchup' " drop-in replacement for the vim plugin matchit.vim
Plug 'haya14busa/incsearch.vim' " Improved incremental searching for Vim
"GUI customization
Plug 'ntpeters/vim-better-whitespace' "Vim Better Whitespace Plugin
Plug 'Shougo/echodoc.vim' "Print documents in echo area.
"Plug 'joshdick/onedark.vim' "Color scheme inspirado por el tema One Dark de Atom.
Plug 'morhetz/gruvbox' " Retro groove color scheme for Vim
Plug 'mhartington/oceanic-next' "Oceanic-Next.vim is a neovim theme inspired
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'  " Temas para airline la barra en la parte baja
"File browsers
Plug 'Shougo/denite.nvim' "Denite is a dark powered plugin for Neovim/Vim to unite all interfaces.
Plug 'scrooloose/nerdtree' "proyect tree and structure
Plug 'tpope/vim-projectionist' "browse to file easy
"Git helpers
Plug 'airblade/vim-gitgutter' " muestra los cambios en archivos en la parte izquierda donde estan los numeros de linea
Plug 'rhysd/git-messenger.vim' "Neovim plugin to reveal the commit messages under the cursor
Plug 'tpope/vim-fugitive' " git on vim
Plug 'xuyuanp/nerdtree-git-plugin' "nerd tree git status
Plug 'jiangmiao/auto-pairs' " automaticamente cierra comillas o llaves
" code browser Tags managers
Plug 'ludovicchabant/vim-gutentags' " tags for vim, makes use of Exhuberant Ctags which generates tags .ctags config file taken from   universal ctags from
" syntax files
Plug 'sheerun/vim-polyglot'
" liquid support
Plug 'tpope/vim-liquid'
" html5 support
Plug 'othree/html5.vim', { 'for': 'html' }
" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'MaxMEllon/vim-jsx-pretty'
" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'yggdroot/indentline' " indent guides lines let's see how they goes
"" vim snnipets
Plug 'epilande/vim-es2015-snippets' " Custom ultisnippets for ES2015 and vim
Plug 'epilande/vim-react-snippets' "Custom ultisnippets for react and vim
" Custom vim Text Objects
Plug 'kana/vim-textobj-user' "vim-textobj-user - Create your own text objects for vim in an easy way
Plug 'michaeljsmith/vim-indent-object' " blocks of indentation as vim text objects
Plug 'wellle/targets.vim'  "Vim plugin that provides additional text objects
Plug 'kana/vim-textobj-line' "Text objects for the current line
Plug 'kana/vim-textobj-entire' "entire file as vim object
" other plugins
Plug 'vim-scripts/ReplaceWithRegister' "avoid visual selection when pasting
Plug 'christoomey/vim-system-copy' " copy into the system
Plug 'machakann/vim-highlightedyank' "highlight yanked text
Plug 'wakatime/vim-wakatime' "vim time tracker
" help you read complex code by showing diff level of parentheses in diff color !!
"Plug 'luochen1990/rainbow'
" file icons
Plug 'ryanoasis/vim-devicons' " vim will become visual studio
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " needed for devicons
Plug 'rhysd/clever-f.vim' "Extended f, F, t and T key mappings for Vim.
Plug 'junegunn/vim-easy-align' "A Vim alignment plugin
Plug 'janko-m/vim-test' "Run your tests at the speed of thought
" vim prettier
" post install (yarn install | npm install)
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()
