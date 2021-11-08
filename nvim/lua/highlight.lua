
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
vim.cmd[[ highlight QuickFixLine cterm=italic,bold ctermfg=NONE ctermbg=NONE ]]

-- Set background color of floating windows
vim.cmd[[ highlight NormalFloat ctermbg=bg guibg=#202020 ]]
vim.cmd[[ highlight FloatBorder ctermbg=NONE guibg=#202020 ]]

-- Change highlighting for selected text in Telescope
vim.cmd[[ highlight TelescopeMatching guifg=orange gui=bold ]]
vim.cmd[[ highlight TelescopeSelection gui=bold ]]

