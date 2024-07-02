" hook_source {{{
" ui
call ddc#custom#patch_global(#{ ui: 'pum' })
      
" sources
call ddc#custom#patch_global('sources', ['around', 'vim-lsp'])

" source options
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy'],
      \ },
      \ 'around': {'mark': '[Around]'},
      \ 'vim-lsp': {
      \   'mark': '[LSP]',
      \   'matchers': ['matcher_head'],
      \   'forceCompletionPattern': '\.|:|->|"\w+/*'
      \ }})

inoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <silent><expr> <Down>
      \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' :
      \ '<Down>'
inoremap <silent><expr> <Up>
      \ pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' :
      \ '<Up>'
inoremap <silent><expr> <CR>
      \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' :
      \ '<CR>'

" command line completion
cnoremap <expr> <Tab>
      \ wildmenumode() ? &wildcharm->nr2char() :
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ ddc#map#manual_complete()
cnoremap <S-Tab> <Cmd>call pum#map#select_relative(-1)<CR>
cnoremap <C-o> <Cmd>call pum#map#confirm()<CR>

" terminal completion
call ddc#enable_terminal_completion()

call ddc#enable(#{
      \   context_filetype: has('nvim') ? 'treesitter' : 'context_filetype',
      \ })
" }}}
