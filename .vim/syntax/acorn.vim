
syn keyword acornKeyword fn type enum
syn keyword acornKeyword do end
syn keyword acornKeyword let var 
syn keyword acornKeyword if elif else then 
syn keyword acornKeyword while for loop
syn keyword acornKeyword ret break continue
syn keyword acornKeyword is

syn keyword acornOperator or and xor not

syn region acornComment start=/#/ end=/\n/

hi def link acornKeyword Keyword
hi def link acornOperator Operator
hi def link acornComment Comment


