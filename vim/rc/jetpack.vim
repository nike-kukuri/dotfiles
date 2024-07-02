source $BASE_DIR/options.vim 
source $BASE_DIR/keymaps.vim 

" start plugin read
packadd vim-jetpack
call jetpack#begin()
call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap

" LSP
call jetpack#add('neoclide/coc.nvim', {'branch': 'release'})

" FF
call jetpack#add('lambdalisue/vim-fall')

" denops
call jetpack#add('vim-denops/denops.vim')
call jetpack#add('vim-skk/skkeleton')
call jetpack#load_toml(expand('$BASE_DIR/ddc/ddc.toml'))

" utils
call jetpack#add('github/copilot.vim')
call jetpack#add('thinca/vim-quickrun')
call jetpack#add('thinca/vim-qfreplace')
call jetpack#add('machakann/vim-sandwich')
call jetpack#add('itchyny/lightline.vim')
call jetpack#add('simeji/winresizer')

" colorscheme
call jetpack#add('EdenEast/nightfox.nvim')
call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('cohama/lexima.vim')

" document
call jetpack#add('vim-jp/vimdoc-ja')
call jetpack#end()
" end plugin read
"
" Load plugin/*.vim
function! s:load_configurations() abort
  for path in glob('$BASE_DIR/plugin/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction
call s:load_configurations()

" plugin configs chores
nnoremap <C-e> <Cmd>WinResizerStartResize<CR>
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
