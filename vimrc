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

"set statusline+=%F "Full path display
set statusline+=%f\ %l\:%c
set laststatus=2
