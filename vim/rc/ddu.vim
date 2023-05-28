" ddu.vim
" nnoremap s<Space> <Cmd>Ddu
"       \ -name=files file
"       \ -source-option-path=`expand('$BASE_DIR')`
"       \ <CR>
" nnoremap ss
"       \ <Cmd>Ddu -name=files file_point file_old
"       \ `'.git'->finddir(';') != '' ? 'file_external' : ''`
"       \ file -source-option-volatile
"       \ file -source-param-new -source-option-volatile
"       \ -unique -expandInput
"       \ -ui-param-displaySourceName=short
"       \ <CR>
" nnoremap sr
"       \ <Cmd>Ddu -name=files -resume<CR>
" nnoremap / <Cmd>Ddu
"       \ -name=search line -resume=v:false
"       \ -ui-param-startFilter=v:false
"       \ <CR>
" nnoremap * <Cmd>Ddu
"       \ -name=search line -resume=v:false
"       \ -input=`expand('<cword>')`
"       \ -ui-param-startFilter=v:false
"       \ <CR>
" nnoremap ;g <Cmd>Ddu
"       \ -name=search rg -resume=v:false
"       \ -ui-param-ignoreEmpty
"       \ -source-param-input='`'Pattern: '->input('<cword>'->expand())`'
"       \ <CR>
" xnoremap ;g y<Cmd>Ddu
"       \ -name=search rg -resume=v:false
"       \ -ui-param-ignoreEmpty
"       \ -source-param-input='`'Pattern: '->input(v:register->getreg())`'
"       \ <CR>
" nnoremap ;f <Cmd>Ddu
"       \ -name=search rg -resume=v:false
"       \ -ui-param-ignoreEmpty
"       \ -source-param-input='`'Pattern: '->input('<cword>'->expand())`'
"       \ -source-option-path=`'Directory: '->input($'{getcwd()}/', 'dir')`
"       \ <CR>
" nnoremap n <Cmd>Ddu
"       \ -name=search -resume
"       \ -ui-param-startFilter=v:false
"       \ <CR>
" nnoremap ;r <Cmd>Ddu
"       \ -name=register register
"       \ -source-option-defaultAction=`'.'->col() == 1 ? 'insert' : 'append'`
"       \ -ui-param-autoResize
"       \ <CR>
" nnoremap ;d <Cmd>Ddu
"       \ -name=outline markdown
"       \ -ui-param-ignoreEmpty -ui-param-displayTree
"       \ <CR>
" xnoremap <expr> ;r
"       \ (mode() ==# 'V' ? '"_R<Esc>' : '"_d')
"       \ .. '<Cmd>Ddu -name=register register
"       \ -source-option-defaultAction=insert
"       \ -ui-param-autoResize<CR>'
" nnoremap sg <Cmd>Ddu dein<CR>
" nnoremap [Space]<Space> <Cmd>Ddu
"       \ -name=search line -resume=v:false
"       \ -source-param-range=window
"       \ -ui-param-startFilter
"       \ <CR>
" 
" "inoremap <C-q> <Cmd>Ddu
" "\ -name=register register
" "\ -source-option-defaultAction=append
" "\ -source-param-range=window
" "\ -ui-param-startFilter=v:false
" "\ <CR>
" inoremap <C-q> <Cmd>call ddu#start(#{
"       \   name: 'file',
"       \   ui: 'ff',
"       \   input: '.'->getline()[: '.'->col() - 1]->matchstr('\f*$'),
"       \   sources: [
"       \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
"       \   ],
"       \   uiParams: #{
"       \     ff: #{
"       \       startFilter: v:true,
"       \       replaceCol: '.'->getline()[: '.'->col() - 1]->match('\f*$') + 1,
"       \     },
"       \   },
"       \ })<CR>
" "cnoremap <C-q> <Cmd>Ddu
" "\ -name=register register
" "\ -source-option-defaultAction=feedkeys
" "\ -source-param-range=window
" "\ -ui-param-startFilter=v:false
" "\ <CR><Cmd>call setcmdline('')<CR><CR>
" cnoremap <C-q> <Cmd>call ddu#start(#{
"       \   name: 'file',
"       \   ui: 'ff',
"       \   input: getcmdline()[: getcmdpos() - 2]->matchstr('\f*$'),
"       \   sources: [
"       \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
"       \   ],
"       \   uiParams: #{
"       \     ff: #{
"       \       startFilter: v:true,
"       \       replaceCol: getcmdline()[: getcmdpos() - 2]->match('\f*$') + 1,
"       \     },
"       \   },
"       \ })<CR><Cmd>call setcmdline('')<CR><CR>
" 
" " Initialize ddu.vim lazily.
" call timer_start(10, { _ -> ddu#start(#{ ui: '' }) })
" 
" call ddu#custom#alias('source', 'file_rg', 'file_external')
" call ddu#custom#alias('action', 'tabopen', 'open')
" 
" call ddu#custom#patch_global(#{
"       \   ui: 'ff',
"       \   uiOptions: #{
"       \     filer: #{
"       \       toggle: v:true,
"       \     },
"       \   },
"       \   uiParams: #{
"       \     ff: #{
"       \       filterSplitDirection: 'floating',
"       \       floatingBorder: 'none',
"       \       previewFloating: v:true,
"       \       previewFloatingBorder: 'single',
"       \       previewSplit: 'no',
"       \       highlights: #{
"       \         floating: 'Normal',
"       \         floatingBorder: 'Special',
"       \       },
"       \       updateTime: 0,
"       \       winWidth: 100,
"       \     },
"       \     filer: #{
"       \       split: 'no',
"       \       sort: 'filename',
"       \       sortTreesFirst: v:true,
"       \       toggle: v:true,
"       \     },
"       \   },
"       \   sourceOptions: #{
"       \     _: #{
"       \       ignoreCase: v:true,
"       \       matchers: ['matcher_substring'],
"       \     },
"       \     file_old: #{
"       \       matchers: [
"       \         'matcher_substring',
"       \         'matcher_relative',
"       \         'matcher_ignore_current_buffer',
"       \       ],
"       \     },
"       \     file_external: #{
"       \       matchers: [
"       \         'matcher_substring',
"       \       ],
"       \     },
"       \     file_rec: #{
"       \       matchers: [
"       \         'matcher_substring', 'matcher_hidden',
"       \       ],
"       \     },
"       \     file: #{
"       \       matchers: [
"       \         'matcher_substring', 'matcher_hidden',
"       \       ],
"       \       sorters: ['sorter_alpha'],
"       \     },
"       \     dein: #{
"       \       defaultAction: 'cd',
"       \     },
"       \     markdown: #{
"       \       sorters: [],
"       \     },
"       \     line: #{
"       \       matchers: [
"       \         'matcher_kensaku',
"       \       ],
"       \     },
"       \     path_history: #{
"       \       defaultAction: 'uiCd',
"       \     },
"       \     rg: #{
"       \       matchers: [
"       \         'matcher_substring', 'matcher_files',
"       \       ],
"       \     },
"       \   },
"       \   sourceParams: #{
"       \     file_external: #{
"       \       cmd: ['git', 'ls-files', '-co', '--exclude-standard'],
"       \     },
"       \     rg: #{
"       \       args: [
"       \         '--ignore-case', '--column', '--no-heading',
"       \         '--color', 'never',
"       \       ],
"       \     },
"       \     file_rg: #{
"       \       cmd: [
"       \         'rg', '--files', '--glob', '!.git',
"       \         '--color', 'never', '--no-messages'],
"       \       updateItems: 50000,
"       \     },
"       \   },
"       \   filterParams: #{
"       \     matcher_kensaku: #{
"       \       highlightMatched: 'Search',
"       \     },
"       \     matcher_substring: #{
"       \       highlightMatched: 'Search',
"       \     },
"       \     matcher_ignore_files: #{
"       \       ignoreGlobs: ['test_*.vim'],
"       \       ignorePatterns: [],
"       \     },
"       \   },
"       \   kindOptions: #{
"       \     file: #{
"       \       defaultAction: 'open',
"       \     },
"       \     word: #{
"       \       defaultAction: 'append',
"       \     },
"       \     deol: #{
"       \       defaultAction: 'switch',
"       \     },
"       \     action: #{
"       \       defaultAction: 'do',
"       \     },
"       \     readme_viewer: #{
"       \       defaultAction: 'open',
"       \     },
"       \   },
"       \   kindParams: #{
"       \     action: #{
"       \       quit: v:true,
"       \     },
"       \   },
"       \   actionOptions: #{
"       \     narrow: #{
"       \       quit: v:false,
"       \     },
"       \     tabopen: #{
"       \       quit: v:false,
"       \     },
"       \   },
"       \ })
" call ddu#custom#patch_local('files', #{
"       \   uiParams: #{
"       \     ff: #{
"       \       split: 'floating',
"       \     }
"       \   },
"       \ })
" 
" call ddu#custom#action('kind', 'file', 'grep', { args -> GrepAction(args) })
" function! GrepAction(args)
"   call ddu#start(#{
"         \   name: a:args.options.name,
"         \   push: v:true,
"         \   sources: [
"         \     #{
"         \       name: 'rg',
"         \       params: #{
"         \         path: a:args.items[0].action.path,
"         \         input: 'Pattern: '->input(),
"         \       },
"         \     },
"         \   ],
"         \ })
" endfunction
" 
" " Define cd action for "ddu-ui-filer"
" call ddu#custom#action('kind', 'file', 'uiCd', { args -> UiCdAction(args) })
" function! UiCdAction(args)
"   const path = a:args.items[0].action.path
"   const directory = path->isdirectory() ? path : path->fnamemodify(':h')
" 
"   call ddu#ui#do_action('itemAction',
"         \ #{ name: 'narrow', params: #{ path: directory } })
" endfunction
" " }}}
" 
" " ddu-ui-filer.vim
" " hook_add {{{
" nnoremap [Space]f <Cmd>Ddu
"       \ -name=filer-`win_getid()` -ui=filer -resume -sync file
"       \ -source-option-path=`t:->get('ddu_ui_filer_path', '')`
"       \ -source-option-columns=filename<CR>
" " }}}
" 
" " hook_source {{{
" autocmd MyAutoCmd TabEnter,WinEnter,CursorHold,FocusGained *
"       \ call ddu#ui#do_action('checkItems')
" " }}}
" 
" " ddu-filer = {{{
" nnoremap <buffer> <Space>
"       \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
" nnoremap <buffer> *
"       \ <Cmd>call ddu#ui#do_action('toggleAllItems')<CR>
" nnoremap <buffer> a
"       \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
" nnoremap <buffer> A
"       \ <Cmd>call ddu#ui#do_action('inputAction')<CR>
" nnoremap <buffer> q
"       \ <Cmd>call ddu#ui#do_action('quit')<CR>
" nnoremap <buffer> o
"       \ <Cmd>call ddu#ui#do_action('expandItem',
"       \ #{ mode: 'toggle' })<CR>
" nnoremap <buffer> O
"       \ <Cmd>call ddu#ui#do_action('expandItem',
"       \ #{ maxLevel: -1 })<CR>
" "nnoremap <buffer> O
" "\ <Cmd>call ddu#ui#do_action('collapseItem')<CR>
" nnoremap <buffer> c
"       \ <Cmd>call ddu#ui#multi_actions([
"       \   ['itemAction', #{ name: 'copy' }],
"       \   ['clearSelectAllItems'],
"       \ ])<CR>
" nnoremap <buffer> d
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'delete' })<CR>
" nnoremap <buffer> D
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'trash' })<CR>
" nnoremap <buffer> m
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'move' })<CR>
" nnoremap <buffer> r
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'rename' })<CR>
" nnoremap <buffer> x
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'executeSystem' })<CR>
" nnoremap <buffer> p
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'paste' })<CR>
" nnoremap <buffer> P
"       \ <Cmd>call ddu#ui#do_action('preview')<CR>
" nnoremap <buffer> K
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'newDirectory' })<CR>
" nnoremap <buffer> N
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'newFile' })<CR>
" nnoremap <buffer> L
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'link' })<CR>
" nnoremap <buffer> u
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'undo' })<CR>
" nnoremap <buffer> ~
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'narrow', params: #{ path: expand('~') } })<CR>
" nnoremap <buffer> =
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'narrow', params: #{ path: getcwd() } })<CR>
" nnoremap <buffer> h
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{ name: 'narrow', params: #{ path: '..' } })<CR>
" nnoremap <buffer> H
"       \ <Cmd>call ddu#start(#{ sources: [#{ name: 'path_history' }] })<CR>
" nnoremap <buffer> I
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ #{
"       \   name: 'narrow',
"       \   params: #{
"       \     path: 'cwd: '->input(b:ddu_ui_filer_path, 'dir')->fnamemodify(':p'),
"       \   }
"       \ })<CR>
" nnoremap <buffer> >
"       \ <Cmd>call ddu#ui#do_action('updateOptions', #{
"       \   sourceOptions: #{
"       \     file: #{
"       \       matchers: ToggleHidden('file'),
"       \     },
"       \   },
"       \ })<CR>
" nnoremap <buffer> <
"       \ <Cmd>call ddu#ui#do_action('updateOptions', #{
"       \   ui: 'ff',
"       \   uiParams: #{
"       \     ff: #{
"       \       split: 'vertical',
"       \     },
"       \   },
"       \ })<CR>
" nnoremap <buffer> <C-l>
"       \ <Cmd>call ddu#ui#do_action('checkItems')<CR>
" nnoremap <buffer><expr> <CR>
"       \ ddu#ui#get_item()->get('isTree', v:false) ?
"       \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow' })<CR>" :
"       \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'open' })<CR>"
" nnoremap <buffer><expr> l
"       \ ddu#ui#get_item()->get('isTree', v:false) ?
"       \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow' })<CR>" :
"       \ "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'open' })<CR>"
" nnoremap <buffer> gr
"       \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'grep' })<CR>
" nnoremap <buffer> t
"       \ <Cmd>call ddu#ui#do_action('itemAction', #{
"       \   name: 'tabopen',
"       \   params: #{ command: 'tabedit' },
"       \ })<CR>
" 
" function! ToggleHidden(name)
"   const current = ddu#custom#get_current(b:ddu_ui_name)
"   const source_options = current->get('sourceOptions', {})
"   const source_options_name = source_options->get(a:name, {})
"   const matchers = source_options_name->get('matchers', [])
"   return matchers->empty() ? ['matcher_hidden'] : []
" endfunction
" " }}}

" my original settings
" call ddu#custom#patch_global({
"     \   'ui': 'ff',
"     \   'uiParams': {
"     \     'ff': {
"     \       'split': 'floating',
"     \       'prompt': '> ',
"     \       'startFilter': v:true,
"     \     }
"     \   },
"     \   'sources': [{'name': 'file_rec', 'params': {}}],
"     \   'sourceOptions': {
"     \     '_': {
"     \       'matchers': ['matcher_substring'],
"     \     },
"     \   },
"     \   'kindOptions': {
"     \     'file': {
"     \       'defaultAction': 'open',
"     \     },
"     \   }
"     \ })
" 
" autocmd FileType ddu-ff call s:ddu_my_settings()
" function! s:ddu_my_settings() abort
"   nnoremap <buffer><silent> <CR>
"         \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
"   nnoremap <buffer><silent> <Space>
"         \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
"   nnoremap <buffer><silent> i
"         \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
"   nnoremap <buffer><silent> q
"         \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
" endfunction
" 
" autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
" function! s:ddu_filter_my_settings() abort
"   inoremap <buffer><silent> <CR>
"   \ <Esc><Cmd>close<CR>
"   nnoremap <buffer><silent> <CR>
"   \ <Cmd>close<CR>
"   nnoremap <buffer><silent> q
"   \ <Cmd>close<CR>
" endfunction
" 
" nnoremap <silent> <C-p> <Cmd>call ddu#start({})<CR>
" 
