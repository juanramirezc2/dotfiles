
"-------------------------LUA VIMRC-------------------------------{{
lua require("lsp_config")
set jumpoptions=stack "the jumplist behaves like the history in a web browser and like the tag stack.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
set cursorline        " highlight current line
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175
set noswapfile

" Indent using spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" split new panels down and below
set splitbelow
set splitright
" " show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" " when indenting with '>', use 2 spaces width
set shiftwidth=2
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Github Copilot depends on <CR> after a comment, this disable the next line
" automatic comment
set formatoptions-=cro
" maximum lenght of characters displayed in a git diff
highlight ColorColumn ctermbg=gray
set colorcolumn=125
" abrir vim.init en un ventana nueva love it
nnoremap <leader>vr :e $MYVIMRC<CR>
nnoremap <silent><leader><CR> :noh<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buscar en el documento lo que este visualmente seleccionado
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

"Switch to alternative buffer
nnoremap <leader><tab> <C-^>;

" Usar Control + y para copiar al portapapeles
vnoremap <leader>c "*y
nnoremap <leader>c "*y
vnoremap <leader>v "*p
nnoremap <leader>v "*p
" Usar <líder> + d para cortar al portapapeles
vnoremap <C-x> "+d
nnoremap <C-x> "+d

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => projectionist
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:projectionist_heuristics = {'*':{}}

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
endfor "
nnoremap <Leader>ec :Ecomponent<Space>
nnoremap <Leader>es :Estylesheet<Space>
nnoremap <leader>et :Etest<Space>
"-- neoformat
let g:neoformat_try_node_exe = 1
" Enable alignment
" let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
" let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
" let g:neoformat_basic_format_trim = 1
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
"----------------------- nvim-tree.lua ------------------
nnoremap <leader>nn :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>
" a list of groups can be found at `:help nvim_tree_highlight`
"highlight NvimTreeFolderIcon guibg=blue
"-------------------------- Twilight nvim --------------------------
nnoremap <leader>tw :Twilight<CR>
"--- Yankstack 
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" The smart snippets use a global options called
 "g:ultisnips_javascript.{option}" which can control the format
 " of trailing semicolon, space before function paren, etc.
 " e.g.

let g:ultisnips_javascript = {
     \ 'keyword-spacing': 'always',
     \ 'semi': 'never',
     \ 'space-before-function-paren': 'always',
     \ }
let g:gutentags_ctags_executable = '/opt/homebrew/bin/ctags'
"----------------------- Github Copilot ------------------
" let g:copilot_no_tab_map = v:true
" imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
