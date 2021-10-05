
scriptencoding utf-8
source ~/.config/nvim/plugins.vim
" Luego de esta línea puedes agregar tus configuraciones y mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide pointless junk at the bottom, doesn't work in .vimrc for some reason?
"
set laststatus=2
set hidden
set showcmd " show incomplete commands
set title " set terminal title
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
set wrap "Wrap lines
" Turn on the Wild menu
set wildmenu
" i'm not agains the mouse, enable it in all modes
set mouse=a
set noshowmode "don't show --INSERT--
set noruler "don't show line numbers/column/% junk
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" detect when a file is changed
set autoread
" Line numbers
set number
"FOLDING SETTINGS======================={{{
" Add a bit extra margin to the left
set foldmethod=indent               " not as cool as syntax, but faster
set foldlevelstart=99               " start unfolded
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
" split new panels down and below
" Denite split wrong here
set splitbelow
set splitright

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
" vim wiki requirement
set nocompatible
" tema y apariencia
set termguicolors  " Activa true colors en la terminal
"it seems that powerline fonts need this
set t_Co=256
set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)

" guicolors styles for every mode
set termguicolors
set cursorline        " highlight current line
"set cursorcolumn      " highlight current column
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif
" set a map leader for more key combos
let mapleader = " "
let maplocalleader= ";"
" no mostrar numeros de linea cuando se abre una terminal :O :O
autocmd TermOpen * setlocal nonumber norelativenumber
" Enable filetype plugins
filetype plugin indent on
" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
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

" draw less
set lazyredraw

if has('nvim')
  tnoremap jk <C-\><C-n>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif
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


function SetCursor() abort
  let s:is_dark=(&background == 'dark')
  if s:is_dark
    let bg  = ['#383838']
  else
    let bg  = ['#dbdbdb']
  endif
  let histring = [ 'hi', 'CursorLine',
        \ 'guifg=' . 'NONE',
        \ 'guibg=' . bg[0],
        \ 'gui=' . 'NONE', 'cterm=' . 'NONE'
        \ ]
  execute join(histring, ' ')
  "set cursor colors for normal and insert mode
  hi! Cursor cterm=NONE gui=NONE guifg=#a4f644 guibg=#a4f644
  hi! Cursor2 guifg=red guibg=red
endfunction
autocmd ColorScheme * call SetCursor()

function SetItalics() abort
  call italics#AddItalicToGroup("Special")
  call italics#AddItalicToGroup("Comment")
  call italics#AddItalicToGroup("Keyword")
  call italics#AddItalicToGroup("Identifier")
  "call italics#AddItalicToGroup("StorageClass")
  "call italics#AddItalicToGroup("xmlAttrib")
  "call italics#AddItalicToGroup("htmlArg")
  "call italics#AddItalicToGroup("jsxAttrib")
  "call italics#AddItalicToGroup("tsxAttrib")
endfunction


"autocmd ColorScheme * call SetItalics()

"Enable syntax highlighting and set colorscheme
set background=light
syntax enable
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
"}}}

let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" so I can go up an down wrapped lines
map j gj
map k gk

" abrir vim.init en un ventana nueva love it
nnoremap <leader>vr :e $MYVIMRC<CR>

" vim-airline ---------------------------------------------------------------{{{
" terminal emulator exit
let g:airline_extensions = ['branch','denite','tabline']
" configuracion para airline
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_statusline_ontop = 0 "no necesito mostrar el status line en la parte de arriba
let g:airline#extensions#tabline#show_close_button = 0  " no necesito mostrar el boton de cerrar tab en la parte de arriba
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' "solo muestra encoding si es diferente de utf-8
let g:airline_section_y = "%{fnamemodify(getcwd(), ':t')}"
let g:airline_section_c = '%t' "filename only in bottom part
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_skip_empty_sections = 1
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
" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 3 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 3 ? "m'" . v:count : '') . 'j'

" maximum lenght of characters displayed in a git diff
highlight ColorColumn ctermbg=gray
set colorcolumn=125
" interactive find replace preview
set inccommand=nosplit
" clear search with shift+enter
nnoremap <silent><leader><CR> :noh<CR>

" ==== denite custom matcher ========""
"" optional - but recommended - see below
nnoremap <leader>; :Denite buffer<CR>
nmap     <leader>p :Denite -start-filter file/rec:.<CR>
nmap     <leader>me :Denite  menu<CR>
nnoremap <leader>/ :<C-u>Denite -no-empty -auto-action='preview' grep:.<CR>
vnoremap <leader>/ y:<C-u>Denite -no-empty  grep:.::<C-R>=fnameescape(@")<CR><CR>
nnoremap <leader>/w :<C-u>DeniteCursorWord grep:.<CR>
nmap     <leader>mr :Denite file_mru<CR>
nnoremap <leader>dp :Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <leader>dn :Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <leader>dl :Denite -resume -do='normal! A;'<CR>
nmap     <leader>sc :Denite -auto-action='preview' colorscheme<CR>

" Add custom menus
let s:menus = {}

let s:menus.dotfiles = {
      \ 'description': 'Edit your dotfiles'
      \ }
let s:menus.dotfiles.file_candidates = [
      \ ['zshrc', '~/.zshrc'],
      \ ['zshenv', '~/.zshenv'],
      \ ['kitty', '~/.config/kitty/kitty.conf'],
      \ ]

let s:menus.my_commands = {
      \ 'description': 'Example commands'
      \ }
let s:menus.my_commands.command_candidates = [
      \ ['Split the window', 'vnew'],
      \ ['Open zsh menu', 'Denite menu:zsh'],
      \ ['Format code', 'FormatCode', 'go,python'],
      \ ]

" Note: rg is faster than ag
call denite#custom#var('file/rec', 'command',
      \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

" Ripgrep command on grep source
call denite#custom#var('grep', {
      \ 'command': ['rg'],
      \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
      \ 'recursive_opts': [],
      \ 'pattern_opt': ['--regexp'],
      \ 'separator': ['--'],
      \ 'final_opts': [],
      \ })

call denite#custom#var('menu', 'menus', s:menus)

" Change matchers.
call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
"call denite#custom#source('file/rec', 'matchers', ['matcher/cpsm'])  "Explore vim Clap
"
"Change sorters.
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])

"call denite#custom#source('file/rec', 'matchers', ['converter/tail_path'])

" Remove date from buffer list
call denite#custom#var('buffer', {
      \ 'date_format': 'buffer',
      \ 'exclude_unlisted': '0'
      \})

" Denite mappings quickfix panel action
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> l denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()

function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_update)
  inoremap <silent><buffer><expr> <Right> denite#do_map('do_action')
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <silent><buffer> <C-j> <Esc>
        \:call denite#move_to_parent()<CR>
        \:call cursor(line('.')+1,0)<CR>
        \:call denite#move_to_filter()<CR>A
  inoremap <silent><buffer> <C-k> <Esc>
	        \:call denite#move_to_parent()<CR>
	        \:call cursor(line('.')-1,0)<CR>
	        \:call denite#move_to_filter()<CR>A
endfunction

call denite#custom#option('default', {
      \ 'match_highlight': 1,
      \ 'smartcase': 1,
      \ 'auto_resize': 1,
      \ 'prompt': 'λ:',
      \ 'expand': 1,
      \ 'highlight_filter_background': 'TermCursor',
      \ 'prompt_highlight': 'Function',
      \ 'highlight_matched_char': 'Function',
      \ 'highlight_matched_range': 'Function',
      \ })

      "\ 'winminheight': 10
      "\ 'direction': 'dynamicbottom',
      "\ 'split': 'no',
      "\ 'vertical_preview': 1,
      "\ 'floating_preview': 1,
      "\ 'preview_width': 60,
      "\ 'auto_action': 'preview',
      "\ 'auto_resize': 1,
      "\ 'source_names': 'short',
      "\ 'auto_action': 'preview',
      "\ 'wincol': &columns / 16 ,
      "\ 'winwidth': &columns * 14/16,

" Vim-Devicons --------------------------------------------------------------{{{
let g:NERDTreeGitStatusNodeColorization = 1
let g:webdevicons_enable_denite = 0

"see actual registers
nnoremap <leader>re :registers<CR>
nnoremap <leader>ma :marks<CR>
set autowrite

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase
" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
autocmd TabLeave *NERD_tree* :wincmd w

" ====== vim wiki ========{{{
let g:vimwiki_list = [{'path': '$HOME/Library/Mobile\ Documents/com~apple~CloudDocs/wiki', 'syntax': 'markdown','ext': '.md'}]
let g:vimwiki_global_ext = 0 " make sure vimwiki doesn't own all .md files
au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
  autocmd!
  " automatically update links on read diary
  autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

let g:vimwiki_ext2syntax = {'.md': 'markdown',
      \ '.mkd': 'markdown',
      \ '.mdown': 'markdown',
      \ '.markdown': 'markdown'}
" }}}

set noemoji

let g:org_todo_keywords = [['TODO(t)', '|', 'DONE(d)'],
      \ ['REPORT(r)', 'BUG(b)', 'KNOWNCAUSE(k)', '|', 'FIXED(f)'],
      \ ['CANCELED(c)']]


"""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste
nmap <leader>ya :Yanks<CR>

"Switch to alternative buffer
nnoremap <leader><tab> <C-^>;
""Nerd Tree ---------------------------------------------------------------------{{{
" Close Nerdtree if is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NerdTree Refresh Root crashes with my <S-R> command for moving between tags
let NERDTreeMapRefreshRoot='r'
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseDir='h'
let NERDTreeMapCloseChildren='H'
" icons looking weird in nerdtree this might fix it
autocmd FileType nerdtree setlocal nolist
"let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1
" Close nerd tree on file open
"let NERDTreeQuitOnOpen=1
let NERDTreeMinimalMenu = 1
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=46
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
"}}}
"Match Tags Always
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'javascript' : 1,
    \ 'typescript.tsx' : 1,
    \ 'twig' : 1,
    \}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim sandwich config
" Annotate strings with gettext
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

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
nnoremap [[ []
nnoremap ]] ][
nnoremap <C-h> ^
vnoremap <C-h> ^
nnoremap <C-l> g_
vnoremap <C-l> g_
nnoremap <silent> <C-j> <c-d>
nnoremap <silent> <C-k> <c-u>
vnoremap <silent> <C-j> <c-d>
vnoremap <silent> <C-k> <c-u>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easy motion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>j <Plug>(easymotion-j)
vmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
vmap <leader>k <Plug>(easymotion-k)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => highlight groups helpers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction
command! -nargs=0 Syn call Syn()

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
" => vim indent Line
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:indentLine_char       = '▏'
"let g:indentLine_faster = 1
"let g:indentLine_setConceal = 0
"let g:indentLine_defaultGroup = 'NonText'
"let g:indentLine_defaultGroup = 'Normal'

"Disable IndentLine for Json files
autocmd Filetype json let g:indentLine_enabled = 0
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim undotree
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:undotree_HighlightChangedWithSign = 0
let g:undotree_WindowLayout             = 4
let g:undotree_SetFocusWhenToggle       = 1
nnoremap <Leader>u :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => word motion
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap cw ce
nmap cW cE

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Jsdoc.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>js <Plug>(jsdoc)
"let g:jsdoc_formatter = "esdoc"
"let g:jsdoc_templates_path = '~/.config/nvim/jsdoc/snippet_template.js'
"-------------------------LSP LUA-------------------------------{{
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

call sign_define('LspDiagnosticsErrorSign',       {'text': '・'})
call sign_define('LspDiagnosticsWarningSign',     {'text': '・'})
call sign_define('LspDiagnosticsInformationSign', {'text': '・'})
call sign_define('LspDiagnosticsHintSign',        {'text': '・'})
"--------------------------nvim cmp -------------------- {{
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })

  -- Setup lspconfig.
  require('lspconfig')['tsserver'].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF