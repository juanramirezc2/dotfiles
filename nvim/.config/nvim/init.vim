scriptencoding utf-8
source ~/.config/nvim/plugins.vim
" Luego de esta línea puedes agregar tus configuraciones y mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide pointless junk at the bottom, doesn't work in .vimrc for some reason?
set laststatus=2
set wrap linebreak nolist
set cpo+=n " show linebreak symbol were line numbers are
set showbreak=↪\ \ \   " show this symbol when line was broken
set ai "Auto indent
set si "Smart indent
set clipboard+=unnamedplus
" i'm not agains the mouse, enable it in all modes
set mouse=a
set noshowmode "don't show --INSERT--
set noruler "don't show line numbers/column/% junk
" Line numbers
set number
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Indent using spaces instead of tabs
set expandtab
" The number of spaces to use for each indent
set shiftwidth=2
" split new panels down and below
set splitbelow
set splitright
"Number of spaces to use for a <Tab> during editing operations
set softtabstop=2"
" vim wiki requirement
set nocompatible
"tell neovim that the background is dark
set background=dark
" tema y apariencia
set termguicolors  " Activa true colors en la terminal
"indent line ======= {{{
" vim indent line
let g:indentLine_enabled = 1
let g:indentLine_faster = 1
" indent line overwrite conceal from user :(
let g:indentLine_concealcursor = 'nc'
let g:indentLine_conceallevel = 2
let g:indentLine_color_gui = '#343d46'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
 let g:indentLine_char="⎸"
" }}}
" avoid messi matchi load
let g:loaded_matchit = 1

let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" guicolors styles for every mode
set termguicolors
set cursorline        " highlight current line
"set cursorcolumn      " highlight current column
:hi Cursor guifg=green guibg=green
:hi Cursor2 guifg=red guibg=red
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" Vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"no swap files in vim they are annoying
"vimR only configurations
if has("gui_vimr")
  " Font for vimR
endif


" set a map leader for more key combos
let mapleader = " "
let maplocalleader= ";"
" open a new terminal  in aplit of the current tab
nmap <leader>st :12sp term://zsh<CR>I
nmap <leader>te :tabnew term://zsh<CR>I

" no mostrar numeros de linea cuando se abre una terminal :O :O
autocmd TermOpen * setlocal nonumber norelativenumber
" Enable filetype plugins
filetype plugin on
filetype indent on
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

:command C call RandomBase16()

 "Start new windows with a random color scheme
call RandomBase16()

syntax on
function SetItalics() abort
  hi Comment gui=italic
  hi Keyword gui=italic
  hi Keyword gui=italic
  hi Identifier gui=italic
  hi StorageClass gui=italic
  hi jsLineComment gui=italic
  hi xmlAttrib gui=italic
  hi htmlArg gui=italic
  hi pythonSelf gui=italic
  hi htmlArg gui=italic
endfunction
autocmd ColorScheme * call SetItalics()
"Enable syntax highlighting and set colorscheme
syntax enable
colorscheme base16-irblack
"}}}
let g:vim_jsx_pretty_highlight_close_tag = 1
" NerdTree Refresh Root crashes with my <S-R> command for moving between tags
let NERDTreeMapRefreshRoot='r'
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseDir='h'
let NERDTreeMapCloseChildren='H'

" Show hidden files/directories
let g:NERDTreeShowHidden = 1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

"Toggle file drawer in/out
nmap <leader>m :NERDTreeFind<CR>
nmap <leader>n :NERDTreeToggle<CR>

" so I can go up an down wrapped lines
map j gj
map k gk

" abrir vim.init en un ventana nueva love it
nnoremap <leader>vr :e $MYVIMRC<CR>

" Usar <líder> + y para copiar al portapapeles
vnoremap <leader>c "+y
nnoremap <leader>c "+y
vnoremap <leader>v "+p
nnoremap <leader>v "+P

" Usar <líder> + d para cortar al portapapeles
vnoremap <leader>x "+d
nnoremap <leader>x "+d

" Cerrar el buffer actual con <líder> + q
nnoremap <silent><S-Q> :q<CR>

" pestanaiguiente  y pesana anterior
nnoremap <S-R> gt
nnoremap <S-E> gT

" moverme entre los diferentes paneles con Shift-w
nnoremap <S-w>   <c-w>w

if has('nvim')
  " Terminal mode:
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
  " Insert mode:
  inoremap <M-h> <Esc><c-w>h
  inoremap <M-j> <Esc><c-w>j
  inoremap <M-k> <Esc><c-w>k
  inoremap <M-l> <Esc><c-w>l
  " Visual mode:
  vnoremap <M-h> <Esc><c-w>h
  vnoremap <M-j> <Esc><c-w>j
  vnoremap <M-k> <Esc><c-w>k
  vnoremap <M-l> <Esc><c-w>l
  " Normal mode:
  nnoremap <M-h> <c-w>h
  nnoremap <M-j> <c-w>j
  nnoremap <M-k> <c-w>k
  nnoremap <M-l> <c-w>l
  "some terminal mappings
  tnoremap jk <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
  " simulare <C-R>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif
" vim-airline ---------------------------------------------------------------{{{
" terminal emulator exit
let g:airline_extensions = ['branch','hunks','coc','denite','tabline']
" configuracion para airline
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_statusline_ontop = 0 "no necesito mostrar el status line en la parte de arriba
let g:airline#extensions#tabline#show_close_button = 0  " no necesito mostrar el boton de cerrar tab en la parte de arriba
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' "solo muestra encoding si es diferente de utf-8
"let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_section_x = '%y'
"let g:airline_section_y = "%{fnamemodify(getcwd(), ':t')}"
" vim airline please don't show me closed buffers
"let g:airline#extensions#tabline#buffer_idx_mode = 1
"let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
"let g:airline#extensions#nvim_typescript#enabled=1
"let g:airline_skip_empty_sections = 1
"only display the filename in airline status
"let g:airline_section_c = '%t'

"let g:airline_mode_map = {
      "\ '__' : '',
      "\ 'c'  : '',
      "\ 'i'  : '',
      "\ 'ic' : '',
      "\ 'ix' : '',
      "\ 'n'  : '',
      "\ 'ni' : '',
      "\ 'no' : '',
      "\ 'R'  : '',
      "\ 'Rv' : '',
      "\ 's'  : '',
      "\ 'S'  : '',
      "\ '' : '',
      "\ 't'  : '',
      "\ 'v'  : '',
      "\ 'V'  : '',
      "\ '' : '',
      "\ }

"let g:airline#extensions#tabline#buffer_idx_format = {
      "\ '0': '0 ',
      "\ '1': '1 ',
      "\ '2': '2 ',
      "\ '3': '3 ',
      "\ '4': '4 ',
      "\ '5': '5 ',
      "\ '6': '6 ',
      "\ '7': '7 ',
      "\ '8': '8 ',
      "\ '9': '9 ',
      "\}

"}}}

"it seems that powerline fonts need this
set t_Co=256
set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive git mappings
nnoremap <silent><leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <silent><leader>gr :Gread<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nmap <silent><leader>gb :Gblame<cr>

" buscar en el documento lo que este visualmente seleccionado
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" siempre abre un archivo bajo el cursor en un nuevo tab
nmap gf <c-w>gf

" enable jsdocs syntax highlight
let g:javascript_plugin_jsdoc = 1

"Enables some additional syntax highlighting for NGDocs. Requires JSDoc plugin to be enabled as well.
let g:javascript_plugin_ngdoc = 1

" Allow MatchTagAlways to highlight JSX
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'javascript.jsx' : 1,
      \}

"user same colors for highlight as vim uses
let g:mta_use_matchparen_group = 1
" startify sessions and other tweaks
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
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
" vim jumps mappings are counterintuirive
nmap <C-G> <S-G>
vnoremap <C-G> <S-G>
nmap <C-H> ^
nmap <C-H> ^
vmap <C-H> ^
nnoremap <C-L> g_
vnoremap <C-L> g_
nnoremap <C-O> <C-I>
nnoremap <C-I> <C-O>
" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 4 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 4 ? "m'" . v:count : '') . 'j'

" easy motions vertical movements
nmap <leader>b <Plug>(easymotion-b)
nmap <leader>w <Plug>(easymotion-w)
nmap <leader>j <Plug>(easymotion-j)
vmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
vmap <leader>k <Plug>(easymotion-k)
"scrolling up and down mappings
nnoremap <silent> <C-j> <c-d>
nnoremap <silent> <C-k> <c-u>
vnoremap <silent> <C-j> <c-d>
vnoremap <silent> <C-k> <c-u>

" jk | Escaping!
inoremap jk <Esc>
cnoremap jk <C-c>

" maximum lenght of characters displayed in a git diff
highlight ColorColumn ctermbg=gray
set colorcolumn=125
" inc search plugin mappings
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
" interactive find replace preview
set inccommand=nosplit
" clear search with shift+enter
nnoremap <silent><leader><CR> :noh<CR>

" ==== denite custom matcher ========""
"" optional - but recommended - see below
let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 1 " default value
" tell denite to use this matcher by default for all sources
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
nnoremap ; :Denite -start-filter -direction=topleft buffer<CR>
nmap <leader>p :Denite -start-filter file/rec:.<CR>
nnoremap <leader>/ :<C-u>Denite -no-empty grep:.<CR>
vnoremap <leader>/ y:<C-u>Denite -no-empty  grep:.::<C-R>=fnameescape(@")<CR><CR>
nnoremap <leader>/w :<C-u>DeniteCursorWord grep:.<CR>
nmap     <leader>dm :Denite file_mru<CR>
nnoremap <leader>dp :Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <leader>dn :Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <leader>dl :Denite -resume -do='normal! A;'<CR>
nmap     <leader>sc :Denite colorscheme<CR>

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc', 'node_modules/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.png'])

" Open file commands
call denite#custom#map('insert,normal', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

" Change file/rec command to ag.
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup','--path-to-ignore',$HOME.'/.ignore','-g', ''])
" narrow by tail path instead of full path in file/rec source.
call denite#custom#source('file/rec', 'matchers', ['converter/tail_path', 'matcher/fuzzy'])
" narrow by tail path instead of full path in file/old source.
call denite#custom#source('file_mru', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])
" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag', '--follow', '--nocolor', '--nogroup','--path-to-ignore',$HOME.'/.ignore'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')
call denite#custom#var('buffer', 'exclude_unlisted', '0')

" Change matchers.
call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

" narrow by path in grep source
"call denite#custom#source('grep','converters', ['converter/abbr_word'])

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
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <c-l> denite#do_map('do_action')
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
      \ 'auto_resize': 1,
      \ 'split': 'floating',
      \ 'direction': 'rightbelow',
      \ 'winminheight': '10',
      \ 'highlight_filter_background': 'TermCursor',
      \ 'prompt': 'λ:',
      \ 'prompt_highlight': 'Function'
      \ })

      "\ 'highlight_window_background': 'Normal',
"call denite#custom#option('default', {
      "\ 'split': 'floating',
      "\ 'auto_resize': 0,
      "\ 'source_names': 'short',
      "\ 'statusline': 0,
      "\ 'wincol': &columns / 10 ,
      "\ 'winheight': 20 ,
      "\ 'winrow': &lines / 2 - 10 ,
      "\ 'winwidth': &columns * 8/10,
      "\ 'winminheight': 1,
      "\ 'vertical_preview': 1,
      "\ 'highlight_mode_normal': 'TermCursor',
      "\ 'highlight_mode_insert': 'TermCursor',
      "\ 'highlight_matched_char': 'Function',
      "\ 'highlight_matched_range': 'Function',
      "\ 'highlight_window_background': 'NormalFloat',
      "\ 'highlight_filter_background': 'TermCursor',
      "\ 'highlight_prompt': 'Special',
      "\ })

" Set cursorline hl
augroup ps_denite_cursorline
    au!
    au WinEnter * if &filetype ==# 'denite'
        \ |   highlight CursorLineDenite guibg=#282c34 gui=bold
        \ |   highlight! link CursorLine CursorLineDenite
        \ | endif
augroup END

" clever f settings
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000
" Vim-Devicons --------------------------------------------------------------{{{

let g:NERDTreeGitStatusNodeColorization = 1
" 
"let g:webdevicons_enable_denite = 0
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = { } " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = 'ﯤ'
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts'] = 'ﯤ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''
"easy align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"see actual registers
nnoremap <leader>re :registers<CR>
set autowrite

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>sw :StripWhitespace<CR>

autocmd TabLeave *NERD_tree* :wincmd w
"thyme pomodoro timer commands
nmap <leader>t :!thyme -d<cr>
nmap <leader>ts :!thyme -s<cr>

"shpotify commands
nmap <leader>sp :!spotify play<cr>
nmap <leader>spb :!spotify play uri spotify play uri spotify:playlist:37i9dQZF1DX5Tgh3tlyc3X<cr>
nmap <leader>spbb :!spotify play uri spotify play uri spotify:playlist:37i9dQZF1DX7EF8wVxBVhG<cr>
nmap <leader>sn :!spotify next<cr>
" ================= coc nvim multiple cursors ====================
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
nmap <silent> <C-c> <Plug>(coc-cursors-position)
" use normal command like `<leader>xi(`
nmap <leader>x  <Plug>(coc-cursors-operator)
vmap <leader>r :CocCommand document.renameCurrentWord<CR>
nmap <leader>r <Plug>(coc-refactor)
"vmap <silent> <C-d> <Plug>(coc-cursors-range)
nmap <silent> <C-d> <Plug>(coc-cursors-word)*
xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
nmap <expr> <silent> <C-w> <SID>select_current_word()

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
set noemoji
let g:vimwiki_list = [{'path': '$HOME/wiki', 'syntax': 'markdown','ext': '.md'}] " set path to a directory inside Dropbox
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

let g:org_todo_keywords = [['TODO(t)', '|', 'DONE(d)'],
      \ ['REPORT(r)', 'BUG(b)', 'KNOWNCAUSE(k)', '|', 'FIXED(f)'],
      \ ['CANCELED(c)']]

" COC CONQUER OF COMPLETION----------------------------------------------------------------------{{{
call coc#add_extension('coc-json',
      \'coc-tsserver',
      \'coc-emmet',
      \'coc-css',
      \'coc-html',
      \'coc-eslint',
      \'coc-snippets',
      \'coc-todolist',
      \'coc-tailwindcss')
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()


" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Using Control - j k l for moving between completions
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
 "provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>di  :<C-u>CocList --normal --auto-preview diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>ex  :<C-u>CocList --normal extensions<cr>
" Show commands.
nnoremap <silent> <space>co  :<C-u>CocList --normal commands<cr>
" latest jump locations
nnoremap <silent> <space>lo  :<C-u>CocList --normal location<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList --normal outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList --normal -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>p  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>ll  :<C-u>CocListResume<CR>
"}}}

"""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffer mappings
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
nnoremap <leader><tab> <C-^>;
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
" Close all the buffers
map <leader>ba :bufdo bd<cr>
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <C-space> ?
" ,f to format code, requires formatters: read the docs
" Code formatting -----------------------------------------------------------{{{
noremap <silent> <leader>f :Neoformat<CR>
let g:standard_prettier_settings = {
      \ 'exe': 'prettier',
      \ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
      \ 'stdin': 1,
      \ }
" }}}
" Show break string same color as the line numbers i dont know if i like it of
" i hate it
"hi! link NonText LineNr
