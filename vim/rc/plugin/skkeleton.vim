imap <silent> <C-j> <Plug>(skkeleton-toggle)
cmap <silent> <C-j> <Plug>(skkeleton-toggle)

let s:vim_skk_dir = expand('~/.config/skk')

function! s:read_json_file(fname)
  return join(readfile(a:fname), "\n")
endfunction

function! s:skkeleton_init() abort
  call add(g:skkeleton#mapped_keys, '<C-l>')
  call skkeleton#register_keymap("input", "[", "katakana")
  call skkeleton#register_keymap("input", "'", "disable")
  call skkeleton#register_keymap("input", "<C-l>", "zenkaku")
  call skkeleton#register_keymap("input", ";", "henkanPoint")

  let path = expand(s:vim_skk_dir) . '/azik_kanatable.json'
  let json_str = s:read_json_file(expand(path))
  let kanaTable = json_decode(json_str)
  let kanaTable[' '] = 'henkanFirst'
  call skkeleton#register_kanatable('azik', kanaTable, v:true)
  
  call skkeleton#config(#{
    \   kanaTable: 'azik',
    \   eggLikeNewline: v:true,
    \   keepState: v:true,
    \   globalDictionaries: [
    \     [printf('%s/SKK-JISYO.L', s:vim_skk_dir), 'enc-jp'],
    \   ],
    \ })

  "call skkleton#initialize()
endfunction

function! s:skkeleton_init_denops_async() abort
  call denops#plugin#wait_async('skkleton', s:skkeleton_init())
endfunction

augroup skkeleton-initialize-pre
  autocmd!
  autocmd User skkeleton-initialize-pre call s:skkeleton_init_denops_async()
augroup END
