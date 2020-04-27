scriptencoding utf-8
source ~/.config/nvim/plugins.vim
" Luego de esta línea puedes agregar tus configuraciones y mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide pointless junk at the bottom, doesn't work in .vimrc for some reason?
:set laststatus=0
" i'm not agains the mouse, enable it in all modes
:set mouse=a
:set noshowmode "don't show --INSERT--
:set noruler "don't show line numbers/column/% junk
" indent line overwrite conceal from user :(
let g:indentLine_concealcursor = ''
let g:indentLine_conceallevel = 2
"call coc#add_extension('coc-json', 'coc-tsserver', 'coc-css' ,'coc-html','coc-emmet', 'coc-eslint', 'coc-snippets','coc-todolist','coc-tailwindcss')
" avoid messi matchi load
let g:loaded_matchit = 1

let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" echodoc by shouldgo
" To use echodoc, you must increase 'cmdheight' value.
let g:echodoc_enable_at_startup = 1

"let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
" guicolors styles for every mode
:set termguicolors
set cursorline        " highlight current line
"set cursorcolumn      " highlight current column
:hi Cursor guifg=green guibg=green
:hi Cursor2 guifg=red guibg=red
:set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" Vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"no swap files in vim they are annoying
set noswapfile 
"vimR only configurations
if has("gui_vimr")
  " Font for vimR
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep the error column always visible (jumpy when linter runs on input)
:set signcolumn=yes

" Indent using spaces instead of tabs
set expandtab

" vim indent line
let g:indentLine_enabled = 1
let g:indentLine_faster = 1
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" The number of spaces to use for each indent
set shiftwidth=2

" Line numbers
:set number

" Don't wrap lines
:set nowrap
" split new panels down and below
:set splitbelow
:set splitright

" set a map leader for more key combos
let mapleader = " "
let maplocalleader= ";"
" open a new terminal  in aplit of the current tab
nmap <leader>st :12sp term://zsh<CR>I
nmap <leader>te :tabnew term://zsh<CR>I

" no mostrar numeros de linea cuando se abre una terminal :O :O
autocmd TermOpen * setlocal nonumber norelativenumber

"Number of spaces to use for a <Tab> during editing operations
set softtabstop=2"
" vim wiki requirement
set nocompatible
filetype plugin off
syntax on
"Enable syntax highlighting and set colorscheme
syntax enable
"tell neovim that the background is dark
set background=dark
" tema y apariencia 
set termguicolors  " Activa true colors en la terminal
"OceanicNext color scheme
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext
"let g:airline_theme='oceanicnext'
let g:gruvbox_transparent_bg=1
let g:gruvbox_italic=1
colorscheme gruvbox
"
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
nnoremap <leader>vr :tabnew $MYVIMRC<CR>

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

" terminal emulator exit
let g:airline_extensions = ['branch','hunks','coc','denite','tabline']
" configuracion para airline
let g:airline_statusline_ontop = 0 "no necesito mostrar el status line en la parte de arriba
let g:airline#extensions#tabline#show_close_button = 0  " no necesito mostrar el boton de cerrar tab en la parte de arriba
let g:airline#extensions#tabline#show_splits = 0
" vim airline please don't show me closed buffers
  let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' ' "  here is how you can define 'straight' tabs
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo
 let g:airline#extensions#tabline#show_tab_count = 0
 let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#excludes = ["*NERD_tree*"]
let airline#extensions#tabline#ignore_bufadd_pat = '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree|*NERD_tree*'
" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_x = '%y'
let g:airline_section_y = "%{fnamemodify(getcwd(), ':t')}"
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1


"it seems that powerline fonts need this
set t_Co=256
" Cargar fuente Powerline y símbolos (ver nota)
let g:airline_powerline_fonts = 1

"only display the filename in airline status 
let g:airline_section_c = '%t'
"let g:airline_section_c = '%-0.20t'
" set of text to display for each mode. this time a single letter is enought

let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

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

" folding code nice config
if has('folding')
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif
" toggle fold of current position Using S-tab 
"nnoremap <Tab> za
"navigate between  close folds OMG taken from https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-closed-folds-in-vim
"nnoremap <silent> <tab>j :call NextClosedFold('j')<cr>
"nnoremap <silent> <tab>k :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

" session management
let g:session_directory = "~/.vim/session"
let g:session_autosave = "no"
let g:session_command_aliases = 1
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
" save file mappings
" Iterm2 key bindings set cmd-s Send Text with 'vim' Special Chars to \<C-S>
noremap  <silent><C-S> :update<CR>
vnoremap <silent><C-S> <C-C>:update<CR>
inoremap <silent><C-S> <C-O>:update<CR>
" muestra el numero de linea relativo hacia abajo y hacia arriba relativo a
" donde estoy
":set relativenumber
" vim jumps mappings are counterintuirive
nmap <C-G> <S-G>
vnoremap <C-G> <S-G>
nmap { [{
nmap } ]}
nmap ( [(
nmap ) ])
nmap <C-H> ^
nmap <C-H> ^
vmap <C-H> ^
nnoremap <C-L> g_
vnoremap <C-L> g_
nnoremap <C-O> <C-I>
nnoremap <C-I> <C-O>
" map  HLM  to leader
" ir con el curso a l medio de la zona visible
nnoremap  <leader>l M
vnoremap  <leader>l M
" ir con el cursor al fina de la zona visible
" easy motions vertical movements
nmap <leader>b <Plug>(easymotion-bd-b)
nmap <leader>w <Plug>(easymotion-bd-w)
nmap <leader>j <Plug>(easymotion-j)
vmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
vmap <leader>k <Plug>(easymotion-k)
" center cursor vertically
nnoremap  <leader>h zz
vnoremap  <leader>h zz
"nmap <C-D> gd
"ctrlp conflict
let g:ctrlp_map = '<leader>p'
" ctrp mapping 
nmap <leader>p <C-P>
" vim Tags mappings are awfull
nnoremap <C-P> g<c-]>
nnoremap <C-U> :pop<cr>
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-^> <C-o><C-^> 
"g*  next matching search (not whole word) pattern under cursor
"g#  previous matching search (not whole word) pattern under cursor
"gd  go to definition/first occurrence of the word under cursor
"let g:comfortable_motion_no_default_key_mappings=1
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 100  " Feel free to increase/decrease this value.
" scroll down and up half of the page smoothly
nnoremap <silent> <C-j> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier  * 1)<CR>
vnoremap <silent> <C-j> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier  * 1)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier  * -1)<CR>
vnoremap <silent> <C-k> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier  * -1)<CR>
" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'
"nnoremap Q @q
"Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" jk | Escaping!
inoremap jk <Esc>
cnoremap jk <C-c>

" maximum lenght of characters displayed in a git diff 
highlight ColorColumn ctermbg=gray
set colorcolumn=125
" inc search plugin mappings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
" interactive find replace preview
set inccommand=nosplit
" clear search with shift+enter
nnoremap <leader><CR> :noh<CR>

" ==== denite custom matcher ========""
"" optional - but recommended - see below
let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 1 " default value
" tell denite to use this matcher by default for all sources
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
"
nnoremap ; :Denite -direction=topleft buffer<CR>
nmap <leader>p :Denite -start-filter file/rec:.<CR>
nmap <leader>o :Denite file/old:.<CR>
nnoremap <leader>f :<C-u>Denite -no-empty grep:.<CR>
vnoremap <leader>f y:<C-u>Denite -no-empty  grep:.::<C-R>=fnameescape(@")<CR><CR>
nnoremap <leader>fw :<C-u>DeniteCursorWord grep:.<CR>
nnoremap <leader>dp :Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <leader>dn :Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <leader>dl :Denite -resume -do='normal! A;'<CR>

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
call denite#custom#source('file/old', 'matchers', ['converter/tail_path', 'matcher/fuzzy'])
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
endfunction

call denite#custom#option('default', {
      \ 'split': 'floating',
      \ 'auto_resize': 0,
      \ 'source_names': 'short',
      \ 'prompt': 'λ:',
      \ 'statusline': 0,
      \ 'highlight_matched_char': 'WildMenu',
      \ 'highlight_matched_range': 'Visual',
      \ 'highlight_window_background': 'NormalFloat',
      \ 'highlight_filter_background': 'TermCursor',
      \ 'highlight_prompt': 'Special',
      \ 'wincol': &columns / 10 ,
      \ 'winheight': 20 ,
      \ 'winrow': &lines / 2 - 10 ,
      \ 'winwidth': &columns * 8/10,
      \ 'winminheight': 1,
      \ 'vertical_preview': 1
      \ })
"JsDoc mappings for a better coding
nmap <silent> <leader>doc <Plug>(jsdoc)
" Set floating window to be slightly transparent
"set winbl=10
" clever f settings
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000
" vim test we need more test
let test#javascript#jest#executable = 'CI=true yarn test --colors'
nnoremap <silent> <Leader>tt :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
" Vim-Devicons --------------------------------------------------------------{{{

let g:NERDTreeGitStatusNodeColorization = 1
" 
let g:webdevicons_enable_denite = 0
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
" karma cli setup
"let test#javascript#karma#executable = 'karma' 
let test#strategy = "neovim"
let g:test#runner_commands = ['Minitest', 'Mocha']
"easy align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"paste multiple times from the same register works for the default register
xnoremap p pgvy
"see actual registers
nnoremap <leader>re :registers<CR>
"gutentags config using exhuberant ctags 
" gutentags out if the way
let g:gutentags_cache_dir = $HOME .'/.cache/guten_tags'
let g:gutentags_exclude_project_root = ['/usr/local', $HOME]
"let g:gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
"if g:gitroot !=# ''
  "let g:gutentags_cache_dir = g:gitroot .'/.git/tags'
"else
  "let g:gutentags_cache_dir = $HOME .'/.cache/guten_tags'
"endif
let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ },
      \ }
let g:gutentags_resolve_symlinks = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_write = 1
" let's build js from vim
"let &makeprg = "npm run build"
nnoremap <Leader>bu :!npm run build<CR>
"nnoremap <Leader>bu :make<CR>
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
nmap <Leader>gp <Plug>(Prettier)
"nnoremap <Leader>gp :silent %!prettier --stdin --stdin-filepath % --trailing-comma all --single-quote<CR>
"save file when focus is lost
let g:vitality_always_assume_iterm = 1

set autowrite
" Put this in vimrc, add custom commands in the function.
:au FocusLost * :wa
"vim calentar using google calendar and google tasks
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
"vim sneak move arround with this guy
let g:sneak#label = 1
nmap <leader>tl :CocList --normal todolist<CR>
nmap <leader>tc :CocCommand todolist.create<CR>
nmap <leader>tu :CocCommand todolist.upload<CR>
nmap <leader>td :CocCommand todolist.download<CR>
nmap <leader>te :CocCommand todolist.export<CR>
nmap <leader>tcl :CocCommand todolist.clearNotice<CR>

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>sw :StripWhitespace<CR>
nmap <space>e :CocCommand explorer<CR>

autocmd TabLeave *NERD_tree* :wincmd w
"
" Highlight the active window even play nice with tmux splits
"
hi ActiveWindow ctermbg=00 | hi InactiveWindow ctermbg=235
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

au VimEnter,WinEnter,BufEnter,BufWinEnter,FocusGained * hi ActiveWindow guibg=NONE | hi InactiveWindow guibg=#212121
au VimLeave,WinLeave,BufLeave,BufWinLeave,FocusLost * hi ActiveWindow guibg=#212121 | hi InactiveWindow guibg=#212121

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
vmap <silent> <C-d> <Plug>(coc-cursors-range)
vnoremap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR><Plug>(coc-cursors-range)<CR>gn
nmap <expr> <silent> <C-d> <SID>select_current_word()

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
set noemoji
let g:vimwiki_list = [{'path': '$HOME/Google Drive/wiki', 'syntax': 'markdown','ext': '.md'}] " set path to a directory inside Dropbox
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
" LSP -----------------------------------------------------------------------{{{

" When nvim's LSP is ready...
" lua require
lua require("lsp_config")
set omnifunc=v:lua.vim.lsp.omnifunc
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
autocmd CursorHold * silent! :lua require'util'.show_line_diagnostics()
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:LspDiagnosticsErrorSign='•'
let g:LspDiagnosticsWarningSign='•'
let g:LspDiagnosticsInformationSign='•'
let g:LspDiagnosticsHintSign='•'
let g:diagnostic_show_sign = 1
/*autocmd CursorHold * silent! :lua require'util'.show_line_diagnostics()*/
" Deoplete ------------------------------------------------------------------{{{

" enable deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
      \ 'auto_complete_delay': 0,
      \ 'smart_case': v:true,
      \})
call deoplete#custom#option('ignore_sources', {'_': ['buffer', 'around', 'member', 'omni']})
let g:echodoc_enable_at_startup=1
let g:echodoc#type="virtual"
set splitbelow
set completeopt+=menuone,noinsert,noselect
set completeopt-=preview
autocmd CompleteDone * pclose

function g:Multiple_cursors_before()
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
  call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

let g:deoplete#file#enable_buffer_path=1
function! Preview_func()
  if &pvw
    setlocal nonumber norelativenumber
  endif
endfunction
autocmd WinEnter * call Preview_func()
" Snipppets deoppet-----------------------------------------------------------------{{{

imap <C-z>  <Plug>(deoppet_expand)
imap <C-f>  <Plug>(deoppet_jump_forward)
imap <C-b>  <Plug>(deoppet_jump_backward)

call deoppet#initialize()
call deoppet#custom#option('snippets_dirs', globpath(&runtimepath, 'neosnippets', 1, 1))
