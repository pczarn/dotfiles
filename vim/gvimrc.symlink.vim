" No scrollbars (left, bottom, right)
set guioptions-=L
set guioptions-=l
set guioptions-=R
set guioptions-=r
set guioptions-=b

" Set the font
if has("eval")
    fun! SetFont(fonts)
        let l:fonts = a:fonts . ","
        while l:fonts != ""
            let l:font = strpart(l:fonts, 0, stridx(l:fonts, ","))
            let l:fonts = strpart(l:fonts, stridx(l:fonts, ",") + 1)
            try
                execute "set guifont=" . l:font
                break
            catch
            endtry
        endwhile
    endfun

    if has('gui_win32') || has('gui_win64')
        call SetFont("Consolas:h9:cANSI,Courier_New:h9:cANSI")
    elseif has('gui_gtk')
        call SetFont("Monospace\ 9")
    elseif has('gui_macvim')
        "use default
    else
        " use default
    endif
endif

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f " file name
    set titlestring+=%h%m%r%w " flags
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif
