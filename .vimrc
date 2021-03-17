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
"set splitright
highlight Comment ctermfg=blue
filetype plugin on

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tmsvg/pear-tree'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'ianding1/leetcode.vim'
Plug 'vimwiki/vimwiki'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'haskell/haskell-mode'
Plug 'morhetz/gruvbox'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" React code snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
" Plug 'SirVer/ultisnips'


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
noremap <S-f> g;
noremap <S-q> gT
noremap <S-w> gt
noremap <S-P> o<Esc>P==
xnoremap <S-k> xkP`[V`]
xnoremap <S-j> xp`[V`]
xnoremap <S-h> <gv
xnoremap <S-l> >gv
xnoremap <Esc> <Esc><Esc>

nmap <C-e> :CocCommand explorer<CR>
nnoremap <C-e> :CocCommand explorer<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

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

" Show full file path under window
set laststatus=2
set statusline+=%F

colorscheme gruvbox
set background=dark

augroup MyCocExplorer
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * let d = expand('%') | if isdirectory(d) | silent! bd | exe 'CocCommand explorer ' . d | endif
augroup END

function! s:explorer_cur_dir()
  let node_info = CocAction('runCommand', 'explorer.getNodeInfo', 0)
  return fnamemodify(node_info['fullpath'], ':h')
endfunction

function! s:exec_cur_dir(cmd)
  let dir = s:explorer_cur_dir()
  execute 'cd ' . dir
  execute a:cmd
endfunction

function! s:init_explorer()
  set winblend=10

  " Integration with other plugins

  " CocList
  nnoremap <buffer> <Leader>fg :call <SID>exec_cur_dir('CocList -I grep')<CR>
  nnoremap <buffer> <Leader>fG :call <SID>exec_cur_dir('CocList -I grep -regex')<CR>
  nnoremap <buffer> <C-p> :call <SID>exec_cur_dir('CocList files')<CR>

  " vim-floaterm
  nnoremap <buffer> <Leader>ft :call <SID>exec_cur_dir('FloatermNew --wintype=floating')<CR>
endfunction

function! s:enter_explorer()
  if &filetype == 'coc-explorer'
    " statusline
    setl statusline=coc-explorer
  endif
endfunction

augroup CocExplorerCustom
  autocmd!
  autocmd BufEnter * call <SID>enter_explorer()
  autocmd FileType coc-explorer call <SID>init_explorer()
augroup END

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']"

" Change directory to the current buffer when opening files.
set autochdir

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-css'
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-m> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

inoremap <S-Tab> <esc>la
inoremap jj <esc>

" Haskell Vim Config 
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_classic_highlighting = 1
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords"

" Haskell Indentation
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2


" Set MarkJS to JS Syntax
au BufReadPost *.marko set syntax=javascript

" CoC CSS
autocmd FileType scss setl iskeyword+=@-@

