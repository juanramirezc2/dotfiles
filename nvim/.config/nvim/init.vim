scriptencoding utf-8
source ~/.config/nvim/plugins.vim
" Luego de esta línea puedes agregar tus configuraciones y mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide pointless junk at the bottom, doesn't work in .vimrc for some reason?
set laststatus=2
set hidden
set nowrap
set sidescroll=16
set ai "Auto indent
set si "Smart indent
set tw=500
" Turn on the Wild menu
set wildmenu
" show the number lines relative
set relativenumber number
" i'm not agains the mouse, enable it in all modes
set mouse=a
set noshowmode "don't show --INSERT--
set noruler "don't show line numbers/column/% junk
" Line numbers
set number
" Add a bit extra margin to the left
set foldcolumn=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile
" split new panels down and below
set splitbelow
set splitright
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set softtabstop=2"
" Linebreak on 500 characters
set lbr
set tw=500
" vim wiki requirement
set nocompatible
" tema y apariencia
set termguicolors  " Activa true colors en la terminal
"it seems that powerline fonts need this
set t_Co=256
set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)
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
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
  " simulare <C-R>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

" guicolors styles for every mode
set termguicolors
set cursorline        " highlight current line
"set cursorcolumn      " highlight current column
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" Vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif
" set a map leader for more key combos
let mapleader = " "
let maplocalleader= ";"
" open a new terminal  in aplit of the current tab
nmap <leader>te :e term://zsh<CR>I

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
  hi! Cursor cterm=NONE gui=NONE guifg=#a4f644 guibg=#a4f644
  hi! Cursor2 guifg=red guibg=red
endfunction

autocmd ColorScheme * call SetCursor()

"Enable syntax highlighting and set colorscheme
syntax enable
colorscheme gruvbox
"}}}

let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" so I can go up an down wrapped lines
map j gj
map k gk

" abrir vim.init en un ventana nueva love it
nnoremap <leader>vr :e $MYVIMRC<CR>

" Cerrar el buffer actual con <líder> + q
nnoremap <silent><S-Q> :q<CR>

" moverme entre los diferentes paneles con Shift-w
nnoremap <S-w>   <c-w>w

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
imap jk <Esc>
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
" highlight search
set hlsearch
" interactive find replace preview
set inccommand=nosplit
" clear search with shift+enter
nnoremap <silent><leader><CR> :noh<CR>

" ==== denite custom matcher ========""
"" optional - but recommended - see below
nnoremap <leader>; :Denite -start-filter -no-auto-action buffer<CR>
nmap     <leader>p :Denite -start-filter -no-auto-action file/rec:.<CR>
nmap     <leader>me :Denite -no-auto-action menu<CR>
nnoremap <leader>/ :<C-u>Denite -no-empty grep:.<CR>
vnoremap <leader>/ y:<C-u>Denite -no-empty  grep:.::<C-R>=fnameescape(@")<CR><CR>
nnoremap <leader>/w :<C-u>DeniteCursorWord grep:.<CR>
nmap     <leader>mr :Denite -no-auto-action file_mru<CR>
nnoremap <leader>h :Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <leader>l :Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <leader>dl :Denite -resume -do='normal! A;'<CR>
nmap     <leader>sc :Denite colorscheme<CR>

" Add custom menus
let s:menus = {}

let s:menus.zsh = {
      \ 'description': 'Edit your import zsh configuration'
      \ }
let s:menus.zsh.file_candidates = [
      \ ['zshrc', '~/.zshrc'],
      \ ['zshenv', '~/.zshenv'],
      \ ]

let s:menus.my_commands = {
      \ 'description': 'Example commands'
      \ }
let s:menus.my_commands.command_candidates = [
      \ ['Split the window', 'vnew'],
      \ ['Open zsh menu', 'Denite menu:zsh'],
      \ ['Format code', 'FormatCode', 'go,python'],
      \ ]

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Ag command on grep source
call denite#custom#var('grep', {
      \ 'command': ['ag'],
      \ 'default_opts': ['-i', '--vimgrep'],
      \ 'recursive_opts': [],
      \ 'pattern_opt': [],
      \ 'separator': ['--'],
      \ 'final_opts': [],
      \ })

call denite#custom#var('menu', 'menus', s:menus)

" Change matchers.
call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
" Change sorters.
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])

call denite#custom#source('file/rec', 'matchers', ['converter/tail_path'])

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
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <c-l> denite#do_map('do_action')
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <silent><buffer> <C-n> <Esc>
        \:call denite#move_to_parent()<CR>
        \:call cursor(line('.')+1,0)<CR>
        \:call denite#move_to_filter()<CR>A
  inoremap <silent><buffer> <C-p> <Esc>
	        \:call denite#move_to_parent()<CR>
	        \:call cursor(line('.')-1,0)<CR>
	        \:call denite#move_to_filter()<CR>A
endfunction

call denite#custom#option('default', {
      \ 'auto_resize': 1,
      \ 'split': 'floating',
      \ 'source_names': 'short',
      \ 'direction': 'dynamicbottom',
      \ 'auto_action': 'preview',
      \ 'match_highlight': 1,
      \ 'smartcase': 1,
      \ 'highlight_filter_background': 'TermCursor',
      \ 'prompt': 'λ:',
      \ 'prompt_highlight': 'Function',
      \ 'highlight_matched_char': 'Function',
      \ 'wincol': &columns / 16 ,
      \ 'winwidth': &columns * 14/16,
      \ 'winminheight': 10,
      \ 'highlight_matched_range': 'Function',
      \ 'vertical_preview': 0,
      \ 'expand': 1,
      \ 'floating_preview': 1
      \ })


"LSP ----------------------------------------------{{
lua require("lsp_config")
call sign_define('LspDiagnosticsErrorSign',       {'text': '・'})
call sign_define('LspDiagnosticsWarningSign',     {'text': '・'})
call sign_define('LspDiagnosticsInformationSign', {'text': '・'})
call sign_define('LspDiagnosticsHintSign',        {'text': '・'})
nnoremap <silent> <leader>gdc    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gtd   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ca    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

"}}
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gdc', '<Cmd>lua vim.lsp.buf.declaration()<CR>',     opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd',  '<Cmd>lua vim.lsp.buf.definition()<CR>',      opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt',  '<Cmd>lua vim.lsp.buf.hover()<CR>',           opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>',  opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs',  '<cmd>lua vim.lsp.buf.signature_help()<CR>',  opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gtd',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>',          opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr',  '<cmd>lua vim.lsp.buf.references()<CR>',      opts)
  "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>',     opts)

  "vim.api.nvim_command [[autocmd CursorHold  <buffer> ]]
  "-- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  "-- vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  "-- vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

"Completion nvim ----------------------------------------------------{{{
let g:completion_enable_auto_popup = 1
inoremap <silent><expr> <c-p> completion#trigger_completion()
hi LspReferenceRead guibg='#343d46'
hi LspReferenceText guibg='#343d46'
hi LspReferenceWrite guibg='#343d46'
let g:completion_enable_snippet = 'UltiSnips'
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
"" }}}
" Diagnostic Nvim -----------------------------------------------------{{
" Always show the signcolumn
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
nnoremap <silent> [d :PrevDiagnosticCycle<CR>
nnoremap <silent> ]d :NextDiagnosticCycle<CR>
nnoremap <silent> <leader>di :OpenDiagnostic<CR>
let g:diagnostic_enable_virtual_text = 0
" }}

" Vim-Devicons --------------------------------------------------------------{{{

let g:NERDTreeGitStatusNodeColorization = 1
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

nmap <leader>sw :StripWhitespace<CR>
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffer mappings
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
nnoremap <leader><tab> <C-^>;
" Close all the buffers
map <leader>ba :bufdo bd<cr>
" Code formatting -----------------------------------------------------------{{{
noremap <silent> <leader>f :Neoformat<CR>

let g:standard_prettier_settings = {
      \ 'exe': 'prettier',
      \ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
      \ 'stdin': 1,
      \ }
" }}}
"
"
" HTML ----------------------------------------------------------------------{{{
let g:neoformat_html_prettier = g:standard_prettier_settings
let g:neoformat_enabled_html = ['prettier']
" }}}

" CSS -----------------------------------------------------------------------{{{

let g:neoformat_scss_prettier = g:standard_prettier_settings
let g:neoformat_enabled_scss = ['prettier']
let g:neomake_scss_enabled_makers = ['stylelint']
lua require 'colorizer'.setup()

"}}}
" vista.vim sidebar with LSP symbols {{{
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#icons = {
      \   "function": "\uf794",
      \   "variable": "\uf71b",
      \  }
nmap <leader>vi :Vista!!<CR>
" }}}
" Or, you could use neovim's virtual virtual text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

"Netrw file explorer in neovim
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"Nerd Tree ---------------------------------------------------------------------{{{
map <C-n> :NERDTreeFind<CR>
" Close Nerdtree if is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NerdTree Refresh Root crashes with my <S-R> command for moving between tags
let NERDTreeMapRefreshRoot='r'
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseDir='h'
let NERDTreeMapCloseChildren='H'
" icons looking weird in nerdtree this might fix it
autocmd FileType nerdtree setlocal nolist
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Show hidden files/directories
let g:NERDTreeShowHidden = 1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1
"}}}
