"================================================================================
" Settings

" Syntax highlighting
syntax on

" Disable wrapping
set nowrap

" We want vim, not vi
set nocompatible

" Display current position in file
set ruler

" Preserve current indent on new lines
set autoindent
set copyindent
set smartindent

" Turn off autoindent when pasting highlighted text - F3 turn back on
set pastetoggle=,p

" Wrap at this column
"set textwidth=78

" Make backspaces delete sensibly
set backspace=indent,eol,start

" Indentation levels every four columns
set tabstop=4

" Convert all tabs typed to spaces
set expandtab

" Indent/outdent by four columns
set shiftwidth=4

" Indent/outdent to nearest tabstop
set shiftround

" Adjust keyword characters to match Perlish identifiers...
set iskeyword+=$
set iskeyword+=%
set iskeyword+=@-@
set iskeyword+=:
set iskeyword-=,

" Allow % to bounce between angles too
set matchpairs+=<:>

" When the page starts to scroll, keep the cursor 3 lines from the top and 3 lines from the bottom
set scrolloff=3

" Make the command-line completion better
set wildmenu

" Redraw only when we need to.
set lazyredraw

" Make sure that unsaved buffers that are to be put in the background are 
" allowed to go in there (ie. the 'must save first' error doesn't come up)
set hidden

" pcre by default
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present

set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep

set fileformats=unix,mac,dos    " Handle Mac and DOS line-endings
                                " but prefer Unix endings

set infercase                   " Adjust completions to match case

set autowrite                   " less nanny messages

set updatecount=10              " swap files rotated every 10 keystrokes (instead of 200)

set encoding=utf-8

" Look up perl command under cursor
set keywordprg=perldoc\ -f

set viminfo='100,<1000,s100
" '100 Marks will be remembered for the last 100 edited files.
" <1000 Limits the number of lines saved for each register to 1000 lines; if a
" register contains more than 1000 lines, only the first 1000 lines are saved.
" s100 Registers with more than 100 KB of text are skipped.


" https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed


" Code folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
"nnoremap <space> za    " space open/closes folds

" Store all undo files in a single directory
if has('persistent_undo')
    set undolevels=5000
    set undodir=~/.vim/undodir
    set undofile
endif

" omnicompletion perl
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

let mapleader=","

" Create an underscore of separators as per asciidoc defaults
noremap <leader>0 <Esc>80i=<Esc>
noremap <leader>1 <Esc>80i-<Esc>
noremap <leader>2 <Esc>80i~<Esc>
noremap <leader>3 <Esc>80i^<Esc>
noremap <leader>4 <Esc>80i+<Esc>

" Clean up whitespace
noremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Save session - reopen session with vim -S
nnoremap <leader>s :mksession<CR>

let perl_extended_vars = 1    " syntax color complex things like @{${"foo"}}
let perl_include_pod   = 1    " include pod.vim syntax file with perl.vim

" Fold perl functions etc
let perl_fold = 1

if !has("gui_running")
    inoremap <C-@> <C-x><C-o>
endif

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.template


"================================================================================
" Keybindings

" Dont use Q for Ex mode
map Q :q

" Stop that stupid window from popping up
map q: :q

" Substitute Y for X Globally - SX/Y<CR>
nmap  S  :%s//g<LEFT><LEFT>

" Do the search: /pattern<CR> then replace all the matches: Mreplacement<CR>
nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Comment/uncomment blocks of code (in vmode)
" v then move up/down then _c/_C
vmap _c :s/^/#/gi<Enter>:nohlsearch<Enter>
vmap _C :s/^#//gi<Enter>:nohlsearch<Enter>

" Use spacebar to page down
nnoremap <SPACE> <PAGEDOWN>

" Move line(s) of text using ALT+[jk], indent with ALT+[hl]
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

" Execute dot on visual selection (from vim masterclass)
vnoremap . :norm.<CR>

" Clear highlighted searchs
nmap <silent> <leader>/ :call HLNextOff() <BAR> :nohlsearch<CR>

" Smart to move windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Save file that requires root privileges
cmap w!! w !sudo tee % >/dev/null

" extract perl code block into a subroutine
" From http://www.bofh.org.uk/2006/09/21/crossing-the-rubicon-again
" source http://fsck.com/~jesse/extract
map ,pex <Esc>:'<,'>! $HOME/bin/extract_perl_sub.pl<CR>


"================================================================================
" Functions

augroup TODOHighlight
    autocmd!
    autocmd BufEnter  *.todo,todo,ToDo,TODO  let b:syntax_was_on = exists("syntax_on")
    autocmd BufEnter  *.todo,todo,ToDo,TODO  syntax enable
    autocmd BufLeave  *.todo,todo,ToDo,TODO  if !getbufvar("%","syntax_was_on")
    autocmd BufLeave  *.todo,todo,ToDo,TODO      syntax off
    autocmd BufLeave  *.todo,todo,ToDo,TODO  endif
augroup END

" Search for current visual selection (from Drew Neil)
" * search forward
" # search backward
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


"================================================================================
" Plugins

" changesqlcase.vim
vmap <leader>uc  :call ChangeSqlCase()<cr>

" RainbowParenthsis.vim
runtime plugin/RainbowParenthsis.vim


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" ‼️  ❗  ❓  🚫  ⛔  ❌  ⁉️  
let g:syntastic_error_symbol = '⛔'
let g:syntastic_warning_symbol = '❗'

" 💩  💥  ☢️  ☣️  ☠️  💣  ❔  ❕  ⚠️  👎   🐛  😱  😨  🤢  ⏰  
let g:syntastic_style_error_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '❕'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


" perl
let g:syntastic_enable_perl_checker = 1

let g:syntastic_perl_perlcritic_thres = 5

" Disable https://github.com/Yggdroot/indentLine by default
let g:indentLine_enabled = 0


"================================================================================

autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
autocmd FileType perl let b:vcm_tab_complete = 'omni'
au FileType perl let b:vcm_omni_pattern = '\h\w*->\h\w*\|\h\w*::'

" Avoid syntax highlight problem for R files - file type detected [r] not [R]
"au! BufNewFile,BufRead *.R,*.Rout,*.r,*.Rhistory,*.Rt,*.Rout.save,*.Rout.fail setf R
au! BufNewFile,BufRead *.R,*.Rout,*.r,*.Rhistory,*.Rt,*.Rout.save,*.Rout.fail set filetype=R


"=====[ Correct common mistypings in-the-fly ]=======================

iab    return  return
iab     print  print
iab       teh  the
iab      liek  like
iab  liekwise  likewise
iab      Perl  Perl
iab      perl  perl
iab      moer  more
iab  previosu  previous



"=====[ Add or subtract comments ]===============================


" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
nmap     <silent> # :call ToggleComment()<CR>j0
vnoremap <silent> # :call ToggleBlock()<CR>


"=====[ Smarter interstitial completions of identifiers ]=============
"
" When autocompleting within an identifier, prevent duplications...

augroup Undouble_Completions
    autocmd!
    autocmd CompleteDone *  call Undouble_Completions()
augroup END

function! Undouble_Completions ()
    let col  = getpos('.')[2]
    let line = getline('.')
    call setline('.', substitute(line, '\(\.\?\k\+\)\%'.col.'c\zs\1', '', ''))
endfunction



"================================================================================
" Color scheme

set t_Co=256
set background=dark
"let g:solarized_termcolors=256 " Improves standard Terminal.app, worse for iTerm2
"let g:solarized_termtrans = 1  " Improves transparency in Terminal.app
"let g:solarized_contrast="high"
colorscheme solarized


"================================================================================
" statusline
" Define 3 custom highlight groups - PoC
"hi User1 ctermbg=green ctermfg=red   guibg=green guifg=red
"hi User2 ctermbg=red   ctermfg=blue  guibg=red   guifg=blue
"hi User3 ctermbg=blue  ctermfg=green guibg=blue  guifg=green

set showmode  showcmd  cmdheight=1
set laststatus=2              " always show statusline
if has("statusline") 
    set statusline =          " clear 
    set statusline+=\ %t      " switch to User1 highlight & file tail 
    set statusline+=\ %y      " [filetype] 
    set statusline+=\ \       " space

    " Display buffer info when more than one buffer
    if bufnr('$') > 1
      set statusline  +=%3*           " switch to User2 highlight 
      set statusline  +=\ Buf:\ %n/   " Current buffer number
      set statusline  +=%{bufnr('$')} " Total number of buffers
      set statusline  +=\             " space
    endif

    set statusline+=%9*       " switch to User2 highlight 
    set statusline+=%=        " right align remainder
    set statusline+=%*        " switch back to statusline highlight
    set statusline+=\ Col:    "
    set statusline+=\ %c      " column
    set statusline+=\ \ Line: "
    set statusline+=\ %l/%L   " line/lines 
    set statusline+=\ \ %p%%  " percent of file 
    set statusline+=\         " final space
endif 


