syntax on
set breakindent
set formatoptions=l
set lbr
set tabstop=4
set softtabstop=4
set noshiftround
set shiftwidth=4
set expandtab
set ai
set nocompatible
set number
set hlsearch
set ruler
set clipboard^=unnamed
set shortmess+=A
set guitablabel=(%N)\ %t\ %M
set backspace=indent,eol,start
set nohlsearch
highlight Comment ctermfg=blue
filetype plugin on


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'sheerun/vim-polyglot'
Plug 'tmsvg/pear-tree'
Plug 'mattn/emmet-vim'
Plug 'ianding1/leetcode.vim'
Plug 'vimwiki/vimwiki'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
" React code snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
Plug 'SirVer/ultisnips'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

vmap u <Nop>
inoremap <S-Tab> <esc>la
inoremap jj <esc>
noremap <S-j> ddp== 
noremap <S-k> ddkP== 
noremap <S-l> >>
noremap <S-h> <<
noremap <S-k> ddkP== 
"noremap <C-j> gj
"noremap <C-k> gk
noremap <S-f> g;
noremap <C-q> gT
noremap <C-w> gt
xnoremap <S-k> xkP`[V`]
xnoremap <S-j> xp`[V`]
xnoremap <S-h> <gv
xnoremap <S-l> >gv
xnoremap <Esc> <Esc><Esc>

"let g:tmux_navigator_no_mappings = 1
"
"nnoremap <silent> <C-l> :TmuxNavigateLeft<cr>
"nnoremap <silent> <C-d> :TmuxNavigateDown<cr>
"nnoremap <silent> <C-u> :TmuxNavigateUp<cr>
"nnoremap <silent> <C-r> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Vim Wiki
let wiki = {}
let g:vimwiki_list = [{
  \ 'path': '$HOME/Dropbox/\!\ MSc\ Computer\ Science',
  \ 'template_path': '$HOME/Dropbox/\!\ MSc\ Computer\ Science/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'js' : 'javascript'}

if !hasmapto('<Plug>VimwikiPrevLink')
  nmap <silent><buffer> <S-Tab> <Plug>VimwikiPrevLink
endif

" React Boilerplate Trigger configuration (Optional)
let g:UltiSnipsExpandTrigger="<C-]>"

" LeetCode Vim
let g:leetcode_browser = 'chrome'
let g:leetcode_solution_filetype = 'python3'

" Remap Emmet Trigger Key
let g:user_emmet_leader_key=',.'

"emmet.syntaxProfiles": { "javascript": "jsx" }

" Default rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'}
            \ }
" See pear-tree/after/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default:
let g:pear_tree_ft_disabled = []

" Pair expansion is dot-repeatable by default:
let g:pear_tree_repeatable_expand = 1

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout = 60

" Automatically map <BS>, <CR>, and <Esc>
let g:pear_tree_map_special_keys = 1

" Default mappings:
"imap <BS> <Plug>(PearTreeBackspace)
"imap <CR> <Plug>(PearTreeExpand)
imap jj <Plug>(PearTreeFinishExpansion)
" Pear Tree also makes <Plug> mappings for each opening and closing string.
"     :help <Plug>(PearTreeOpener)
"     :help <Plug>(PearTreeCloser)

" Not mapped by default:
" <Plug>(PearTreeSpace)
" <Plug>(PearTreeJump)
" <Plug>(PearTreeExpandOne)
" <Plug>(PearTreeJNR)

function! NetrwOpenMultiTab(current_line,...) range
   " Get the number of lines.
   let n_lines =  a:lastline - a:firstline + 1

   " This is the command to be built up.
   let command = "normal "

   " Iterator.
   let i = 1

   " Virtually iterate over each line and build the command.
   while i < n_lines
      let command .= "tgT:" . ( a:firstline + i ) . "\<CR>:+tabmove\<CR>"
      let i += 1
   endwhile
   let command .= "tgT"

   " Restore the Explore tab position.
   if i != 1
      let command .= ":tabmove -" . ( n_lines - 1 ) . "\<CR>"
   endif

   " Restore the previous cursor line.
   let command .= ":" . a:current_line  . "\<CR>"

   " Check function arguments
   if a:0 > 0
      if a:1 > 0 && a:1 <= n_lines
         " The current tab is for the nth file.
         let command .= ( tabpagenr() + a:1 ) . "gt"
      else
         " The current tab is for the last selected file.
         let command .= (tabpagenr() + n_lines) . "gt"
      endif
   endif
   " The current tab is for the Explore tab by default.

   " Execute the custom command.
   execute command
endfunction

" Define mappings.
augroup NetrwOpenMultiTabGroup
   autocmd!
   autocmd Filetype netrw vnoremap <buffer> <silent> <expr> t ":call NetrwOpenMultiTab(" . line(".") . "," . "v:count)\<CR>"
   autocmd Filetype netrw vnoremap <buffer> <silent> <expr> T ":call NetrwOpenMultiTab(" . line(".") . "," . (( v:count == 0) ? '' : v:count) . ")\<CR>"
augroup END


" Hide Dot Files in Explorer
let g:netrw_list_hide = '^\..*'        " or anything you like
let g:netrw_hide = 1                   " hide by default

inoremap <S-Tab> <esc>la
inoremap jj <esc>

