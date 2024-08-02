" Global extension names to install when they aren't installed
let g:coc_global_extensions = [
  \ 'coc-deno',
  \ 'coc-diagnostic',
  \ 'coc-git',
  \ 'coc-go',
  \ 'coc-json',
  \ 'coc-lua',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-sumneko-lua',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \]

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

nmap <nowait> gd <Plug>(coc-definition)
nmap <nowait> gD <Plug>(coc-declaration)
nmap <nowait> gi <Plug>(coc-implementation)
nmap <nowait> gy <Plug>(coc-type-definition)
nmap <nowait> gr <Plug>(coc-references)
nmap <nowait> gR <Plug>(coc-refactor)
nmap <nowait> gq <Plug>(coc-format)
nmap <nowait> gQ <Plug>(coc-format-selected)
vmap <nowait> gQ <Plug>(coc-format-selected)
nmap <nowait> qf <Plug>(coc-fix-current)
nmap <nowait> <Leader>rn <Plug>(coc-rename)
nmap <nowait> <Leader><C-k> <Plug>(coc-codeaction)
nmap <nowait> g<C-k> <Plug>(coc-codeaction-cursor)
vmap <nowait> <C-k> <Plug>(coc-codeaction-selected)

" Use [[ and ]]  to navigate diagnostics
nnoremap <silent> <Plug>(my-zv) <Cmd>call timer_start(10, { -> feedkeys("zv", "nx") })<CR>
nmap <nowait> [d <Plug>(coc-diagnostic-prev)<Plug>(my-zv)
nmap <nowait> ]d <Plug>(coc-diagnostic-next)<Plug>(my-zv)
nmap <nowait><silent> qd <Cmd>call CocAction('diagnosticToggle')<CR>

xmap <nowait> if <Plug>(coc-funcobj-i)
xmap <nowait> af <Plug>(coc-funcobj-a)
omap <nowait> if <Plug>(coc-funcobj-i)
omap <nowait> af <Plug>(coc-funcobj-a)
xmap <nowait> ic <Plug>(coc-classobj-i)
xmap <nowait> ac <Plug>(coc-classobj-a)
omap <nowait> ic <Plug>(coc-classobj-i)
omap <nowait> ac <Plug>(coc-classobj-a)

" Use K to show documentation in preview window
function! s:show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'help' expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute printf('!%s', &keywordprg) expand('<cword>')
  endif
endfunction
nnoremap <silent> K <Cmd>call <SID>show_documentation()<CR>
vnoremap <silent> K <Cmd>call CocActionAsync('doHover')<CR>
