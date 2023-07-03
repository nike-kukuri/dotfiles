" hook_source {{{
call ddu#custom#patch_global(#{
        \ ui: 'ff',
        \ sources: [
        \   #{ 
        \       name: 'file_rec',
        \       params: {
        \         'ignoredDirectories': ['.git', 'node_modules', 'vendor'],
        \       },
        \   },
        \ ],
        \ sourceOptions: #{
        \   _: #{
        \     matchers: ['matcher_substring'],
        \   },
        \   channel: #{
        \     columns: ['filename'],
        \   },
        \ },
        \ uiParams: #{
        \   ff: #{
        \     startFilter: v:true,
        \     split: 'floating',
        \     prompt: '> ',
        \     autoAction: #{ name: 'preview' },
        \     filterFloatingPosition: 'bottom',
        \     winCol: &columns/8,
        \     winWidth: 15,
        \     winRow: &lines/8,
        \     winHeight: 10,
        \     previewWidth: 10,
        \     previewHeight: 10,
        \     previewFloating: v:true,
        \     previewFloatingBorder: 'single',
        \     previewSplit: 'vertical',
        \     previewFloatingTitle: 'Preview',
        \     previewWindowOptions: [
        \       [ '&signcolumn', 'no' ],
        \       [ '&foldcolumn', 0 ],
        \       [ '&foldenable', 0 ],
        \       [ '&number', 0 ],
        \       [ '&wrap', 0 ],
        \       [ '&scrolloff', 0 ],
        \     ],
        \     highlights: #{
        \       floating: 'Normal',
        \       floatingBorder: 'Normal',
        \     },
        \     ignoreEmpty: v:true,
        \   },
        \ },
        \ filterParams: #{
        \   matcher_substring: #{
        \     highlightMatched: 'Title',
        \   },
        \ },
        \ kindOptions: #{
        \   file: #{
        \     defaultAction: 'open',
        \   },
        \ }
        \ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  setlocal cursorline
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
	inoremap <buffer> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open' })<CR>
	inoremap <buffer> <C-o>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open', 'params' : { 'command' : 'split'} })<CR>
	inoremap <buffer> <C-v>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open', 'params' : { 'command' : 'vsplit'} })<CR>
	inoremap <buffer> <C-t>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name' : 'open', 'params' : { 'command' : 'tabnew'} })<CR>
	inoremap <buffer> <C-s>
				\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
	inoremap <buffer> <C-n>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
	inoremap <buffer> <C-p>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>
	inoremap <buffer> q
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

nnoremap <C-p> <Cmd>Ddu
      \ -name=files file
      \ -source-option-path=`expand('$BASE_DIR')`
      \ <CR>

nnoremap <silent> <C-q> <Cmd>call ddu#start(#{
      \ name: 'file',
      \ ui: 'ff',
      \ sync: v:true,
      \ input: getcmdline()[: getcmdpos() - 2]->match('\f*$') + 1,
      \ sources: [
      \   #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
      \ ],
      \ uiParams: #{
      \   ff: #{
      \     startFilter: v:true,
      \     replaceCol: getcmdline()[: getcmdpos() - 2]->match('\f*$') + 1,
      \   },
      \ },
      \ })<CR><Cmd>call setcmdline('')<CR><CR>
" }}}
