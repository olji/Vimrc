set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#2d2d2d
  hi CursorColumn guibg=#2d2d2d
  hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444
  hi PmenuSel 	guifg=#000000 guibg=#cae682
endif

" General colors
hi Normal       guifg=#660066 guibg=#FFBBFF gui=none     
hi Cursor       guifg=#FFCCFF guibg=#EE00EE gui=none     
hi CursorLine   guifg=NONE    guibg=#FFCCFF gui=bold     
hi CursorColumn guifg=NONE    guibg=#FFCCFF gui=bold     
hi Incsearch    guifg=#660066 guibg=#FFAAFF gui=italic   
hi Search       guifg=#FFBBFF guibg=#FF00FF gui=italic   
hi LineNr       guifg=#FFBBFF guibg=#FF00FF gui=bold     
hi VertSplit 	guifg=#770077 guibg=#770077 gui=none
hi NonText 		guifg=#808080 guibg=#303030 gui=none
hi StatusLine 	guifg=#f6f3e8 guibg=#444444 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold
hi Visual		guifg=#FFAAFF guibg=#880088 gui=none
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none

" Syntax highlighting
hi Comment 		guifg=#FF00FF guibg=#BB00BB gui=italic
hi Todo 		guifg=#FFFFFF guibg=#BB00BB gui=italic
hi Constant 	guifg=#e5786d guibg=NONE    gui=none
hi String 		guifg=#FF1188 guibg=NONE    gui=italic
hi Identifier 	guifg=#FF22FF guibg=NONE    gui=none
hi Function 	guifg=#FF22FF guibg=NONE    gui=none
hi Type 		guifg=#FF22FF guibg=NONE    gui=none
hi Statement 	guifg=#BB00BB guibg=NONE    gui=none
hi Keyword		guifg=#BB00BB guibg=NONE    gui=none
hi PreProc 		guifg=#e5786d guibg=NONE    gui=none
hi Number		guifg=#EE22AA guibg=NONE    gui=bold
hi Special		guifg=#e7f6da guibg=NONE    gui=none
