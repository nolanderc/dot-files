
set indentexpr=GetAcornIndent()

set indentkeys+=0=end,0=else,0=elif

function! GetAcornIndent()
    let line = getline(v:lnum)
    let prevNum = prevnonblank(v:lnum-1)
    let prev = getline(prevNum)

    " Indent extra if matching these patterns
    let inc_pattern = "\\v(do|then|else|\\=)\\s*$"
    let dec_pattern = "\\v^\\s*(end|elif|else)"

    let inc = 0
    let dec = 0

    if prev =~ inc_pattern
        echom 'increment'
        let inc = &shiftwidth
    endif

    if line =~ dec_pattern
        echom 'decrement'
        let dec = &shiftwidth
    endif

    return indent(prevNum) + inc - dec
endfunction

