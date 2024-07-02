source $BASE_DIR/options.vim 
source $BASE_DIR/keymaps.vim 

" start plugin read
packadd vim-jetpack
call jetpack#begin()
call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap
call jetpack#add('neoclide/coc.nvim', {'branch': 'release'})
call jetpack#add('lambdalisue/vim-fall')
call jetpack#load_toml(expand('$BASE_DIR/dein.toml'))
call jetpack#load_toml(expand('$BASE_DIR/ddc.toml'))
call jetpack#load_toml(expand('$BASE_DIR/dein_lazy.toml'))

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
