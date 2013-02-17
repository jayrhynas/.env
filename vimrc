set backspace=indent,eol,start   " Allow backspacing over indents, end of lines and start of lines
set whichwrap+=<,>,[,],h,l       " Allow moving the cursor over the end of lines and start of lines
set tabstop=4                    " Default tabstop is 4
set softtabstop=4                " However we set our soft tab stop (number of spaces in a row that
set expandtab                    " counts as a tab to 4). With expand tab this makes vi behave like
set shiftwidth=4                 " tabstop is 4 when it's not. Shiftwidth is the number of spaces to
set smarttab                     " use for autoindent. smarttab allows us to backspace a 'tab' of 4 
"set textwidth=80                 " characters and insert the same at the beginning of a line.

set clipboard=unnamed

" Helpful vim features
set wildmenu                     " Command line completion operatings in enhanced mode
set confirm                      " Confirm save of unsaved documents on quit
set hidden                       " Buffer (file) is hidden when abandoned
set number                       " Puts line numbers on by default 'set nonumber' turns them off
set incsearch                    " Search as the search is typed in i.e. '/abc would find the first
set ruler                        " a, then ab, then abc. Ruler shows status line in vim (not vi)
set laststatus=2                 " always show a status line on the last window
set nowrap                       " Lines do not wrap on screen to next line. (Doesn't affect file)
set ignorecase                   " Ignore case in search paterns
set smartcase                    " If Caps are used in search, then don't ignore case in search 
set smartindent                  " Do smart autoindenting of next line
set autoindent                   " Auto indent next line if current line is indented
set showmatch                    " When a bracket is inserted, briefly jump to matching bracket
set viminfo+=%                   " Save open buffers on exit, reopen on start

set noeb                         " No bell for errors
set vb                           " Visual bell (i.e. no bell)
set t_vb=                        " Turn off visual bell as well
au GUIEnter * set vb t_vb=       " t_vb gets reset on entering GUI, so clear it automatically

" Show when a line extends beyond the edge of the screen, and print nbsp characters
set list
set lcs=tab:\ \ ,precedes:<,extends:>,nbsp:·

" Highlight trailing whitespaces with the NonText style
:autocmd Syntax * syn match NonText /\s\+$/ containedin=ALL
:autocmd Syntax * syn match NonText /\t\+/ containedin=ALL

" Highlight long lines
"highlight OverLength ctermbg=black ctermfg=white guibg=#1A1A1A
":autocmd Syntax * syn match OverLength /\%81v.\+/ containedin=ALL

" Treat trailing spaces as errors
"let c_space_errors=1
"let c_no_tab_space_error=1

" Code folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable " start unfolded
set foldlevel=1

" Tags
set tags=tags;/         " recursively search for tags
set nocscopetag         " stop cscope from overriding tag commands
" cscope mappings
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Autocomplete
filetype plugin on
"set ofu=syntaxcomplete#Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp$complete#Main

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" MiniBufferExplorer
let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs  = 1
let g:miniBufExplModSelTarget       = 1 " try to load in unmodifable buffers
let g:miniBufExplUseSingleClick     = 1
let g:miniBufExplTabWrap            = 1

" ShowMarks
let g:showmarks_enable = 0 " disable by default

" Bclose (closes current buffer without closing window)
nmap <C-W><C-W> <Plug>Kwbd

" Most recently used files
let MRU_File = $HOME . "/.vim/mru_files"

" NERD Tree
map <silent> <F7> :NERDTreeToggle $DEPOT<CR>
let NERDTreeChDirMode = 2
let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksFile = $HOME . "/.vim/NERDTreeBookmarks"

autocmd BufWinLeave NERD_tree_1 buffer NERD_tree_1
autocmd BufWinLeave __Tagbar__ buffer __Tagbar__
map <silent> <F8> :TagbarToggle<CR>

" Syntastic options
let g:syntastic_mode_map={ "mode": "passive",
                         \ "active_filetypes": [],
                         \ "passive_filetypes": [] }
let g:syntastic_auto_loc_list=1
let g:syntastic_auto_jump=1
let g:syntastic_stl_format='[%E{E:%e}%B{ }%W{W:%w}]'
" Default ruler contents: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%<%f\ %h%m%r%=%-14.(%#warningmsg#%{SyntasticStatuslineFlag()}%*\ %l,%c%V%)\ %P

colorscheme darkspectrum
" GVIM specific options
if has("gui_running")
  " Turn off GUI elements, use console instead of popup dialogs
  set guioptions-=T
  " Maximize window
  set lines=999 columns=999
endif

" Visual mode searching
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> / :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Clear search pattern by pressing <ESC>
nnoremap <TAB> :noh<CR><TAB>

" Autocomplete brackets, quotes, and comment delimiters
"
" Inserts closing delimiter only if at end of line
function! ConditionalPairMap(open, close)
  let line = getline('.')
  let col = col('.')
  if col < col('$') || stridx(line, a:close, col + 1) != -1
    return a:open
  else
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif
endf
inoremap        (      ()<Left>
inoremap <expr> )      strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> {      ConditionalPairMap('{', '}')
inoremap        {<CR>  {<CR>}<Esc>O
inoremap <expr> }      strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap        [      []<Left>
inoremap <expr> ]      strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap        <      <><Left>
inoremap <expr> >      strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"
inoremap <expr> /*     ConditionalPairMap('/*', '*/')

" Extract the word before the cursor,
" use keyword definitions, skip latter spaces
" (from http://hermitte.free.fr/vim/ressources/dollar_VIM/plugin/words_tools_vim.html)
function! GetNthPreviousWord(n)
  let lig = getline(line('.'))
  let lig = strpart(lig,0,col('.')-1)
  return matchstr(lig, '\<\k*\>\s*\ze'.repeat('\s\+\<\k*\>\s*', a:n-1).'$')
endfunction

" Some C autocompletions
function! Complete()
  let word = GetNthPreviousWord(1)
  if word =~ '^if$'
    let word2 = GetNthPreviousWord(2)
    let extra = ''
    if word2 =~ '^else\s*$'
        let extra = repeat("\<RIGHT>", 7)
    endif
    return "\<ESC>bcwif(  ) {\<CR>}\<ESC>O\<UP>".extra
  elseif word =~ '^for$'
    return "\<ESC>bcwfor(  ) {\<CR>}\<ESC>O\<UP>\<RIGHT>"
  elseif word =~ '^switch$'
    return "\<ESC>bcwswitch(  ) {\<CR>}\<ESC>O\<UP>".repeat("\<RIGHT>", 4)
  else
    return "()\<LEFT>"
  endif
endfunction

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp inoremap ( <C-R>=Complete()<CR>

" Move lines of text with ALT+up/ALT+down
" nmap <M-Down>   mz:m+<cr>`z
" nmap <M-Up>     mz:m-2<cr>`z
" vmap <M-Down>   :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-Up>     :m'<-2<cr>`>my`<mzgv`yo`z
nnoremap <silent> <M-Down> mz:m+<CR>==`z
nnoremap <silent> <M-Up>   mz:m-2<CR>==`z
inoremap <silent> <M-Down> <Esc>:m+<CR>==gi
inoremap <silent> <M-Up>   <Esc>:m-2<CR>==gi
vnoremap <silent> <M-Down> :m'>+<CR>gv=gv
vnoremap <silent> <M-Up>   :m-2<CR>gv=gv

" Shift+arrow keys: select from cursor
no <S-Up> v<Up>
no <S-Down> v<Down>
no <S-Left> v<Left>
no <S-Right> v<Right>
vn <S-Up> <Up>
vn <S-Down> <Down>
vn <S-Left> <Left>
vn <S-Right> <Right>
" Alt+Shift+arrow keys: block select from cursor
no <M-S-Up>    <C-v><Up>
no <M-S-Down>  <C-v><Down>
no <M-S-Left>  <C-v><Left>
no <M-S-Right> <C-V><Right>
vn <M-S-Up>    <Up>
vn <M-S-Down>  <Down>
vn <M-S-Left>  <Left>
vn <M-S-Right> <Right>
" Ctrl+shift+arrow keys: line select from cursor
no <C-S-Up>    V<Up>
no <C-S-Down>  V<Down>
no <C-S-Left>  V<Left>
no <C-S-Right> V<Right>
vn <C-S-Up>    <Up>
vn <C-S-Down>  <Down>
vn <C-S-Left>  <Left>
vn <C-S-Right> <Right>

" Toggle paste mode
map <silent> <leader>p :setlocal paste!<CR>:setlocal paste?<CR>

" Switching between .cpp and .hpp
let g:fsnonewfiles=1
au! BufEnter *.cpp let b:fswitchdst = 'hpp' | let b:fswitchlocs = './,../include/,reg:!main[^/]*!\\0/include!'
au! BufEnter *.hpp let b:fswitchdst = 'cpp' | let b:fswitchlocs = './,reg:!include/!!'

nmap <silent> <F12> :FSHere<CR>
"au! BufWinEnter *.cpp if bufwinnr('.hpp') != -1|call FSwitch('%', 'wincmd l')|else|call FSwitch('%', 'vsplit | wincmd l')|endif

" Source help files
helptags $HOME/.vim/doc

" Notes
augroup filetypedetect
    au BufNewFile,BufRead *.notes setf notes
augroup END
