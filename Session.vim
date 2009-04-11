let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/code/rails/notlr
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +4 app/views/notes/create.js.rjs
badd +90 public/javascripts/prototype.js
badd +1 public/javascripts/modalbox.js
badd +102 public/javascripts/application.js
badd +19 app/views/notes/index.html.erb
badd +6 app/views/notes/_note.html.erb
badd +96 public/stylesheets/notlr.css
badd +4 app/models/note.rb
badd +7 ~/code/rails/notlr/db/migrate/20090411053121_add_deleted_at_to_notes.rb
badd +85 app/controllers/notes_controller.rb
badd +1 app/views/notes/new.js.rjs
badd +2 app/views/notes/_new.html.erb
badd +8 app/controllers/application_controller.rb
args [BufExplorer]
set lines=39 columns=155
edit public/javascripts/application.js
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=3
setlocal nofen
let s:l = 141 - ((32 * winheight(0) + 18) / 36)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
141
normal! 0
tabedit app/views/notes/_note.html.erb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 77) / 155)
exe '2resize ' . ((&lines * 18 + 19) / 39)
exe 'vert 2resize ' . ((&columns * 123 + 77) / 155)
exe '3resize ' . ((&lines * 17 + 19) / 39)
exe 'vert 3resize ' . ((&columns * 123 + 77) / 155)
argglobal
enew
file NERD_tree_2
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=3
setlocal nofen
wincmd w
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=3
setlocal nofen
let s:l = 6 - ((5 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
6
normal! 020l
wincmd w
argglobal
edit app/controllers/notes_controller.rb
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=3
setlocal nofen
let s:l = 57 - ((3 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
57
normal! 016l
wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 77) / 155)
exe '2resize ' . ((&lines * 18 + 19) / 39)
exe 'vert 2resize ' . ((&columns * 123 + 77) / 155)
exe '3resize ' . ((&lines * 17 + 19) / 39)
exe 'vert 3resize ' . ((&columns * 123 + 77) / 155)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . s:sx
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
