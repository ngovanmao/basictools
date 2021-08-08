" Indent automatically depending on filetype
" filetype indent on
set autoindent

set tabstop=4

set shiftwidth=4
set expandtab
"
" " Turn on line numbering. Turn it off with "set nonu" 
" set number
"
" " Set syntax on
 syntax on
"
" " Case insensitive search
 set ic
"
" " Higlhight search
 set hls
"
" " Wrap text instead of being on one line
" set lbr
"
" " Change colorscheme from default to delek
" colorscheme delek
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateTags()

autocmd FileType c,cpp,java,php,py autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType c,cpp,java,php,py autocmd BufWritePre <buffer> :retab

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
    ''
endfunction

set list listchars=trail:.,extends:>
autocmd FileWritePre *.c,*.cpp,*.java,*.py call TrimWhiteSpace()
autocmd FileAppendPre *.c,*.cpp,*.java,*.py call TrimWhiteSpace()
autocmd FilterWritePre *.c,*.cpp,*.java,*.py* call TrimWhiteSpace()
autocmd BufWritePre *.c,*.cpp,*.java,*.py call TrimWhiteSpace()

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

color desert

"set statusline+=%F "Full path display
set statusline+=%f\ %l\:%c
set laststatus=2

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%101v.\+/

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
fun! LongLineHighlightInit()
    if !exists("w:llh")
        call LongLineHighlightOn()
    endif
endfunction

fun! LongLineHighlightOn()
    "let w:llh = matchadd("OverLength", '\%81v.')
    let w:llh = matchadd("OverLength", '\%81v.\+')
endfunction

fun! LongLineHighlightOff()
    call matchdelete(w:llh)
    let w:llh = 0
endfunction

fun! LongLineHighlightToggle()
    if !exists("w:llh") || w:llh == 0
        call LongLineHighlightOn()
    else
        call LongLineHighlightOff()
    endif
endfunction

augroup LongLineHighlight
    autocmd BufWinEnter * call LongLineHighlightInit()
augroup end


noremap <F3> : call LongLineHighlightToggle()<CR>


fun! PasteToggle()
    if !exists("w:paste") || w:paste == 0
        let w:paste = 1
        set paste
    else
        let w:paste = 0
        set nopaste
    endif
endfunction

noremap <F4> : call PasteToggle()<CR>
