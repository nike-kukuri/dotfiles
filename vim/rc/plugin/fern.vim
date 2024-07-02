let g:fern#renderer = "nerdfont"
let g:fern#window_selector_use_popup = 1
function! s:fern_init() abort
  nnoremap <buffer> <silent> q :q<CR>
  map <buffer> <silent> <C-x> <Plug>(fern-action-open:split)
  map <buffer> <silent> <C-v> <Plug>(fern-action-open:vsplit)
  map <buffer> <silent> <C-t> <Plug>(fern-action-tcd)
endfunction

let g:fern#default_hidden = 1
let g:fern#default_exclude = '.git$'

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_init()
augroup END

nnoremap <silent> <Leader>f :Fern . -drawer<CR>
function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

