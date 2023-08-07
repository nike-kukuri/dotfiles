" hook_source {{{
nnoremap <C-f> <Cmd>call ddu#start({})<CR>
call ddu#custom#patch_global(#{
    \   ui: 'ff',
    \   uiParams: #{
    \     ff: #{
    \       split: "horizontal",
    \       startFilter: v:true,
    \       prompt: "> ",
    \       autoAction: #{ name: "preview" },
    \       startAutoAction: v:true,
    \       previewFloating: v:false,
    \       previewFloatingBorder: "rounded",
    \       previewSplit: "vertical",
    \       previewFloatingTitle: "Preview",
    \       filterFloatingPosition: "top",
    \       highlights: #{
    \         floating: 'Normal',
    \         floatingBorder: 'Normal',
    \       },
    \       ignoreEmpty: v:true,
    \       }
    \   },
    \   sources: [#{ name: 'file_rec', params: {}}],
    \   sourceOptions: #{
    \     _: #{
    \       matchers: ['matcher_substring'],
    \     },
    \   },
    \   kindOptions: #{
    \     file: #{
    \       defaultAction: 'open',
    \     },
    \   }
    \ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  inoremap <buffer><silent> <Esc>
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
  \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
  \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>close<CR>
	inoremap <buffer> <C-n>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
	inoremap <buffer> <C-p>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>
endfunction
" }}}
