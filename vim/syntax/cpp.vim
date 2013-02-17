" cpp.vim
"
" Extra C++ syntax highlighting, some are Kaleidescape-specific

" Prevent multiple inclusion
if exists( 'loaded_k_cpp_syntax' )
    syn clear kFunction
    syn clear kMacro
    syn clear kMember
    syn clear kType
    syn clear kIType
    syn clear kClass
endif
let loaded_k_cpp_syntax = 1

syn match kFunction /\zs[a-zA-Z]\w*\ze(/
syn match kMacro    /\<[_A-Z][_A-Z0-9x]*\>/
syn match kMember   /\.\zs[_a-z][_a-z0-9]*\>/
syn match kMember   /->\zs[_a-z][_a-z0-9]*\>/
syn match kType     /^\s*\zs[A-Z]\w*[a-z]\w*\ze\s\+\h\w*/
syn match kType     /::\zs[A-Z]\w*[a-z]\w*\>\ze[^:(]/
syn match kType     /[A-Z]\w*[a-z]\w*\ze\s*[&*][^&]/
syn match kIType    /\<\(int8\|unsigned8\|int16\|unsigned16\|int32\|unsigned32\|int64\|unsigned64\|int_addr\|unsigned_addr\)\>/
syn match kClass    /[_A-Z]\w*\ze::/

hi link kMacro    Macro
hi link kFunction Function
hi link kMember   Identifier
hi link kIType    Type
" kType is like Type, but not bold - color values have to be copied manually
hi      kType     guifg=#8ae234
" Title may not be a good highlight under different colorschemes; change as necessary
hi link kClass    Title
