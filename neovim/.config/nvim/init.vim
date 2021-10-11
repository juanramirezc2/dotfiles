
scriptencoding utf-8
source ~/.config/nvim/plugins.vim
" Luego de esta línea puedes agregar tus configuraciones y mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide pointless junk at the bottom, doesn't work in .vimrc for some reason?
"
set laststatus=2
set hidden
set showcmd " show incomplete commands
set nowrap

" Don’t add empty newlines at the end of files
set binary
set noeol
set sidescroll=16
set hlsearch "Highlight Search

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
" Turn on the Wild menu
set wildmenu
" i'm not agains the mouse, enable it in all modes
set mouse=a
set noruler "don't show line numbers/column/% junk
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" detect when a file is changed
set autoread
" Line numbers
set number
"FOLDING SETTINGS======================={{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Centralize backups, swapfiles and undo history
if has('persistent_undo')         "check if your vim version supports
  set undodir=~/.vim/undo     "directory where the undo files will be stored
  set undofile                    "turn on the feature
endif
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Indent using spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
"Number of spaces to use for a <Tab> during editing operations
set shiftwidth=2
set softtabstop=2
" tema y apariencia
"it seems that powerline fonts need this
set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)
set cursorline        " highlight current line
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" set a map leader for more key combos
let mapleader = " "
let maplocalleader= ";"
" no mostrar numeros de linea cuando se abre una terminal :O :O
autocmd TermOpen * setlocal nonumber norelativenumber
" Enable filetype plugins
filetype plugin indent on
"Always show current position
set ruler
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" For regular expressions turn magic on
set magic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
" Usar Control + y para copiar al portapapeles
vnoremap <leader>c "*y
nnoremap <leader>c "*y
vnoremap <leader>v "*p
nnoremap <leader>v "*p
" Usar <líder> + d para cortar al portapapeles
vnoremap <C-x> "+d
nnoremap <C-x> "+d

tnoremap jk <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" open a new terminal  in aplit of the current tab
noremap <leader>te :e term://zsh<CR>I
noremap <leader>tes :12split term://zsh<CR>I
noremap <leader>tev  :vsplit term://zsh<CR>I

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>no :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" Themes, Commands, etc  ----------------------------------------------------{{{
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Random color schemes!
function RandomColorScheme()
  let mycolors = split(globpath(&rtp,"**/colors/*.vim"),"\n")
  let colorsname = fnamemodify(mycolors[localtime() % len(mycolors)], ":t:r")
  sil exe 'colorscheme ' . colorsname
endfunction
:command NewColor call RandomColorScheme()

function RandomBase16()
  let mycolors = split(globpath(&rtp,"**/colors/base16*.vim"),"\n")
  let colorsname = fnamemodify(mycolors[localtime() % len(mycolors)], ":t:r")
  sil exe 'colorscheme ' . colorsname
endfunction

nmap <leader>ra :call RandomBase16()<CR>

"Enable syntax highlighting and set colorscheme
set background=light
syntax enable
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
"}}}

" so I can go up an down wrapped lines
map j gj
map k gk

" abrir vim.init en un ventana nueva love it
nnoremap <leader>vr :e $MYVIMRC<CR>

"----------------------- vim-lualine -----------------------------------------{{{

"let g:airline_section_y = "%{fnamemodify(getcwd(), ':t')}"
" escaping normal mode
inoremap jk <Esc>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive git mappings
let g:fugitive_pty = 0
nnoremap <silent><leader>gs :Git<CR>
nnoremap <leader>gp :Git push<CR>
"nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite!<CR>
nnoremap <silent><leader>gr :Gread<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gre :Git rebase -i HEAD~6<CR>
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2 <CR> 
nnoremap gdl :diffget //3 <CR>
"| diffupdate
nmap <silent><leader>gb :Gblame<cr>

" buscar en el documento lo que este visualmente seleccionado
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" startify sessions and other tweaks
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_relative_path = 1
let g:startify_use_env = 1
let g:startify_session_dir = '~/.vim/session'
let g:startify_files_number = 10
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_commands = [
      \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
      \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
      \   { 'ch': [ 'check Health', ':checkhealth' ] },
      \   { 'cc': [ 'coc Config', ':CocConfig' ] },
      \ ]

let g:startify_bookmarks = [
      \ { 'c': '~/.config/nvim/init.vim' },
      \ { 'g': '~/.gitconfig' },
      \ { 'z': '~/.zshrc' }
      \ ]

nmap <leader>st :Startify<cr>
" maximum lenght of characters displayed in a git diff
highlight ColorColumn ctermbg=gray
set colorcolumn=125
" interactive find replace preview
set inccommand=nosplit
" clear search with shift+enter
nnoremap <silent><leader><CR> :noh<CR>
"see actual registers
nnoremap <leader>re :registers<CR>
nnoremap <leader>ma :marks<CR>
set autowrite

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

"""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste
nmap <leader>ya :Yanks<CR>

"Switch to alternative buffer
nnoremap <leader><tab> <C-^>;

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Test
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:root_markers = ['package.json', '.git/']
function! s:RunVimTest(cmd)
    " I guess this part could be replaced by projectionist#project_root
    for marker in g:root_markers
        let marker_file = findfile(marker, expand('%:p:h') . ';')
        if strlen(marker_file) > 0
            let g:test#project_root = fnamemodify(marker_file, ":p:h")
            break
        endif
        let marker_dir = finddir(marker, expand('%:p:h') . ';')
        if strlen(marker_dir) > 0
            let g:test#project_root = fnamemodify(marker_dir, ":p:h")
            break
        endif
    endfor

    execute a:cmd
endfunction

nnoremap <leader>tf :call <SID>RunVimTest('TestFile')<cr>
nnoremap <leader>tn :call <SID>RunVimTest('TestNearest')<cr>
nnoremap <leader>tf :call <SID>RunVimTest('TestSuite')<cr>
nnoremap <leader>ts :call <SID>RunVimTest('TestFile')<cr>
nnoremap <leader>tl :call <SID>RunVimTest('TestLast')<cr>
nnoremap <leader>tv :call <SID>RunVimTest('TestVisit')<cr>

"testing strategies
let test#strategy = {
  \ 'nearest': 'vimux',
  \ 'file':    'neovim',
  \ 'suite':   'neovim',
\}
"create react app doesn't list jest in the dependencies
"let g:test#javascript#runner = 'reactscripts'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Core mappings changed
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-h> ^
vnoremap <C-h> ^
nnoremap <C-l> g_
vnoremap <C-l> g_
nnoremap <silent> <C-j> <c-d>
nnoremap <silent> <C-k> <c-u>
vnoremap <silent> <C-j> <c-d>
vnoremap <silent> <C-k> <c-u>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clever F
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => projectionist
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:projectionist_heuristics = {
      \   '*': {
      \     '*.c': {
      \       'alternate': '{}.h',
      \       'type': 'source'
      \     },
      \     '*.h': {
      \       'alternate': '{}.c',
      \       'type': 'header'
      \     },
      \   }
      \ }

" Helper function for batch-updating the g:projectionist_heuristics variable.
function! s:project(...)
  for [l:pattern, l:projection] in a:000
    let g:projectionist_heuristics['*'][l:pattern] = l:projection
  endfor
endfunction

" Set up projections for JS variants.
for s:extension in ['.js', '.jsx', '.ts', '.tsx']
  call s:project(
        \ ['*' . s:extension, {
        \   'alternate': [
        \     '{dirname}/{basename}.test' . s:extension,
        \     '{dirname}/__tests__/{basename}.test' . s:extension,
        \     '{dirname}/__tests__/{basename}-test' . s:extension,
        \     '{dirname}/__tests__/{basename}-mocha' . s:extension
        \   ],
        \   'type': 'source'
        \ }],
        \ ['*.test' . s:extension, {
        \   'alternate': '{basename}' . s:extension,
        \   'type': 'test',
        \ }],
        \ ['**/__tests__/*.test' . s:extension, {
        \   'alternate': '{dirname}/{basename}' . s:extension,
        \   'type': 'test'
        \ }],
        \ ['**/__tests__/*-test' . s:extension, {
        \   'alternate': '{dirname}/{basename}' . s:extension,
        \   'type': 'test'
        \ }],
        \ ['**/__tests__/*-mocha' . s:extension, {
        \   'alternate': '{dirname}/{basename}' . s:extension,
        \   'type': 'test'
        \ }])
endfor
" Provide config for repos where I:
"
" - want special config
" - don't want to (or can't) commit a custom ".projections.json" file
" - can't set useful heuristics based on what's in the root directory
"
function! s:UpdateProjections()
  let l:cwd=getcwd()
  if l:cwd == expand('~/code/liferay-npm-tools')
    for l:pkg in glob('packages/*', 0, 1)
      call s:project(
            \ [l:pkg . '/src/*.js', {
            \   'alternate': l:pkg . '/test/{}.js',
            \   'type': 'source'
            \ }],
            \ [l:pkg . '/test/*.js', {
            \   'alternate': l:pkg . '/src/{}.js',
            \   'type': 'test'
            \ }])
    endfor
  endif
endfunction

call s:UpdateProjections()

if has('autocmd') && exists('#DirChanged')
  augroup WincentProjectionist
    autocmd!
    autocmd DirChanged * call <SID>UpdateProjections()
  augroup END
endif
nnoremap <Leader>ec :Ecomponent<Space>
nnoremap <Leader>es :Estylesheet<Space>
nnoremap <leader>et :Etest<Space>
"--------------------------- CMP ------------------------------------
set completeopt=menu,menuone,noselect
" draw less
set lazyredraw
set updatetime=300
"-------------------------LUA VIMRC-------------------------------{{
lua require("lsp_config")
"--------------------------vim prettier -------------------- {{
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
"----------------------- telescope nvim ----------------
" Find files using Telescope command-line sugar.
nnoremap <leader>tff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>tfg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tfb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>tfh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>tts <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>tgf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>tgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>tgb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>tr <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <leader>tof <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>tcs <cmd>lua require('telescope.builtin').colorscheme()<cr>
"----------------------- nvim-tree.lua ------------------
nnoremap <leader>nn :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
"highlight NvimTreeFolderIcon guibg=blue
"-------------------------- Twilight nvim --------------------------
nnoremap <leader>tw :Twilight<CR>
