
" if exists("b:current_syntax")
"     finish
" endif

syn keyword wgslType void f32 i32 u32 bool
syn keyword wgslContainerType vec2 vec3 vec4
syn keyword wgslContainerType mat2x2 mat2x3 mat2x4 
syn keyword wgslContainerType mat3x2 mat3x3 mat3x4 
syn keyword wgslContainerType mat4x2 mat4x3 mat4x4 
syn keyword wgslContainerType atomic array ptr

syn keyword wgslStorageType sampler sampler_comparison
syn keyword wgslStorageType texture_1d texture_storage_1d
syn keyword wgslStorageType texture_2d texture_storage_2d texture_depth_2d
syn keyword wgslStorageType texture_3d texture_storage_3d
syn keyword wgslStorageType texture_2d_array texture_storage_2d_array texture_depth_2d_array
syn keyword wgslStorageType texture_cube texture_cube_array texture_depth_cube texture_depth_cube_array
syn keyword wgslStorageType texture_multisampled_2d texture_depth_multisampled_2d

syn keyword wgslValueBool true false
syn match wgslValueNumber "\v-?\d+"
syn match wgslValueNumber "\v-?\d+\.\d*(e-?\d+)?"

syn keyword wgslKeyword let var
syn keyword wgslKeyword fn type struct
syn keyword wgslKeyword return continue break continuing
syn keyword wgslKeywordRepeat for loop while
syn keyword wgslKeywordConditional if else elseif switch
syn keyword wgslKeywordLabel case default fallthrough

syn keyword wgslKeyword fn nextgroup=wgslFunctionName skipwhite skipempty
syn match wgslFunctionName "\w\+" contained display
syn match wgslFunctionCall "\w\+("he=e-1,me=e-1

syn match wgslField "\.\w\+"hs=s+1,ms=s+1 display

syn region wgslLineComment start="//" end="$"

syn region wgslAttributeBlock matchgroup=wgslAttributeMarker start="\[\[" end="\]\]" contains=wgslAttributeKeyword,wgslValueNumber,wgslAttributeValue,wgslAttributeParens

syn match wgslAttributeParens contained "(" 
syn match wgslAttributeParens contained ")" 

syn keyword wgslAttributeKeyword contained align binding block builtin group interpolate invariant location override size stage stride workgroup_size

syn keyword wgslAttributeValue contained vertex_index instance_index position front_facing frag_depth local_invocation_id local_invocation_index global_invocation_id workgroup_id num_workgroups sample_index sample_mask
syn keyword wgslAttributeValue contained vertex fragment compute
syn keyword wgslAttributeValue contained perspective linear flat
syn keyword wgslAttributeValue contained center centroid sample

hi def link wgslType Type
hi def link wgslContainerType Type

hi def link wgslValueBool Boolean
hi def link wgslValueNumber Number

hi def link wgslKeyword Keyword
hi def link wgslKeywordRepeat Repeat
hi def link wgslKeywordConditional Conditional
hi def link wgslKeywordLabel Label

hi def link wgslFunctionName Function
hi def link wgslFunctionCall Function
hi def link wgslField Identifier

hi def link wgslLineComment Comment

hi def link wgslAttributeMarker PreProc
hi def link wgslAttributeKeyword PreProc
hi def link wgslAttributeParens Typedef
hi def link wgslAttributeValue Typedef

let b:current_syntax = "wgsl"
