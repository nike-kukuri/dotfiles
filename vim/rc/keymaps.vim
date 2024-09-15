" --- keymaps ---
nnoremap <Esc><Esc> :nohlsearch<CR> 
nnoremap <Leader>. :tabnew ~/.vimrc<CR>
nnoremap <C-G><C-G> :Ripgrep <C-R><C-W><CR>
nnoremap <Leader>re :%s;\<<C-R><C-W>\>;g<Left><Left>;

" open terminal
nnoremap <Leader>tt :<C-u>tabnew<CR><BAR>:terminal<CR>

" Paste with C-v
inoremap <expr> <C-v> printf('<C-r><C-o>%s', v:regster)
cnoremap <expr> <C-v> printf('<C-r><C-o>%s', v:regster)

" move tab
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap cm ct

" remove insert mode in terminal
tnoremap <C-]> <C-\><C-n>

" Home / End
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
onoremap H ^
onoremap L $

" Emacs like in Insert/Command
inoremap <C-d> <Del>
inoremap <C-k> <C-o>C
inoremap <silent> <C-f> <Right>
inoremap <silent> <C-b> <Left>
inoremap <silent> <C-e> <C-o>A
inoremap <silent> <C-a> <C-o>I
cnoremap <C-d> <Del>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" https://github.com/yuki-yano/dotfiles/blob/c56b219116de1693c45c20b03b109497896d5b16/.vimrc#L602-L605
nnoremap <expr> i len(getline('.')) ? 'i' : '"_cc'
nnoremap <expr> A len(getline('.')) ? 'A' : '"_cc'

nnoremap x "_x
nnoremap s "_s
nnoremap c "_c

" move pair ()
nnoremap <Tab><Leader> %

" better <
nnoremap < <<
nnoremap > >>

nnoremap ' :
vnoremap ' :

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" less key motion
onoremap 9 i(
onoremap [ i[
onoremap { i{
onoremap a9 a(

nnoremap v9 vi(
nnoremap v[ vi[
nnoremap v{ vi{
nnoremap va9 va(

onoremap ' i'
onoremap " i"

nnoremap Y y$

nnoremap [b <Cmd>bnext<CR>
nnoremap ]b <Cmd>bprevious<CR>
nnoremap [<Space> O<ESC>cc<ESC>
nnoremap ]<Space> o<ESC>cc<ESC>

nnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-j> }
vnoremap <C-k> {

nnoremap <C-d> <Cmd>keepjumps normal! <C-d><CR>
nnoremap <C-u> <Cmd>keepjumps normal! <C-u><CR>
vnoremap <C-d> <Cmd>keepjumps normal! <C-d><CR>
vnoremap <C-u> <Cmd>keepjumps normal! <C-u><CR>
nnoremap <C-j> <Cmd>keepjumps normal! }<CR>
nnoremap <C-k> <Cmd>keepjumps normal! {<CR>
vnoremap <C-j> <Cmd>keepjumps normal! }<CR>
vnoremap <C-k> <Cmd>keepjumps normal! {<CR>

" split window
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l

" Repeatable add blank line
" https://zenn.dev/vim_jp/articles/8de697fc88e63c
function! s:blank_above(type = '') abort
  if a:type == ''
    set operatorfunc=function('s:blank_above')
    return 'g@ '
  endif

  put! =repeat(nr2char(10), v:count1)
  normal! '[
endfunction

function! s:blank_below(type = '') abort
  if a:type == ''
    set operatorfunc=function('s:blank_below')
    return 'g@ '
  endif

  put =repeat(nr2char(10), v:count1)
endfunction

nnoremap <expr> ]<Space> <sid>blank_below()
nnoremap <expr> [<Space> <sid>blank_above()

" https://zenn.dev/kawarimidoll/articles/54e38aa7f55aff
inoremap <expr> /
      \ complete_info(['mode']).mode == 'files' && complete_info(['selected']).selected >= 0
      \   ? '<c-x><c-f>'
      \   : '/'
