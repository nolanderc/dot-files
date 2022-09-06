
function highlight(group, opts)
    expanded = ''
    for name, value in pairs(opts) do
        expanded = expanded..' '..name..'='..value
    end
    vim.cmd('highlight '..group..expanded)
end

-- Change color of fuzzy find selection
vim.cmd[[ highlight TelescopeSelection gui=bold ]]
vim.cmd[[ highlight TelescopeMatching  guifg=orange, gui='bold' ]]

-- Make the hightlight color less distracting
vim.cmd[[ highlight QuickFixLine gui=italic,bold guifg=NONE guibg=NONE ]]

-- Set background color of floating windows
vim.cmd[[ highlight NormalFloat guibg=#202020 ]]
vim.cmd[[ highlight FloatBorder guibg=#202020 ]]

-- Change highlighting for selected text in Telescope
vim.cmd[[ highlight TelescopeMatching guifg=orange gui=bold ]]
vim.cmd[[ highlight TelescopeSelection guifg=fg gui=bold ]]

-- Change highlighting of doc comments
vim.cmd[[ highlight rustCommentLineDoc gui=italic guifg=#d65d0e ]]
vim.cmd[[ highlight rustCommentBlockDoc gui=italic guifg=#d65d0e ]]

-- Highlight markdown headers
vim.cmd[[ highlight mkdHeading guifg=green ]]

-- Add italic text to markdown
vim.cmd[[ highlight htmlItalic gui=italic ]]

-- Highlight the use keyword in rust correctly
vim.cmd[[ highlight link rustTSInclude rustKeyword ]]

-- Highlight operators
vim.cmd[[ highlight Operator gui=NONE guifg=darkorange ]]
vim.cmd[[ highlight link TSOperator Operator ]]
