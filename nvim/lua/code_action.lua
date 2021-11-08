local M = {}
local api = vim.api
local CONFIG = {}

local actions = nil
local buffer = nil;
local window = nil

local function close_query_window()
    api.nvim_buf_delete(buf, { force = true })
    actions = nil
    window = nil
    buf = nil
end

local function perform_action(action)
    if action.edit.documentChanges ~= nil then
        for _, change in pairs(action.edit.documentChanges) do
            vim.lsp.util.apply_text_document_edit(change)
        end
    end

    if action.edit.changes ~= nil then
        for uri, edit in pairs(action.edit.changes) do
            local buf = vim.uri_to_bufnr(uri)
            vim.lsp.util.apply_text_edits(edit, buf)
        end
    end
end

function M.query_user_done()
    if buffer == nil then return end

    local cursor = api.nvim_win_get_cursor(window)
    local action = actions[cursor[1]]

    close_query_window()

    perform_action(action)
end

function M.query_user_cancel()
    if buffer == nil then return end
    close_query_window()
end

function open_query_window(action_names)
    -- Find the length of the longest name, at least 8 characters
    local max_action_width = 8
    for _, name in pairs(action_names) do
        max_action_width = math.max(max_action_width, #name)
    end

    -- Create a scratch buffer with the actions
    buffer = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(buffer, 0, #actions, false, action_names)

    -- Mappings for choosing an action
    local done_command = "lua require'code_action'.query_user_done()"
    api.nvim_buf_set_keymap(buffer, 'i', '<CR>', '<cmd>'..done_command..'<CR><ESC>', {})
    api.nvim_buf_set_keymap(buffer, 'n', '<CR>', '<cmd>'..done_command..'<CR>', {})

    -- Mappings canceling the choice
    local cancel_command = "lua require'code_action'.query_user_cancel()"
    api.nvim_buf_set_keymap(buffer, 'n', '<ESC>', '<cmd>'..cancel_command..'<CR>', {})

    -- Mappings to quickly choose the n:th action
    for i = 1, #action_names do
        api.nvim_buf_set_keymap(buffer, 'n', tostring(i), i .. 'gg<CR>', {})
    end

    -- Create a window below the cursor with enough space for the actions
    local window_config = {
        relative = 'cursor',
        anchor = 'NW',
        row = 0,
        col = 0,
        width = max_action_width,
        height = #action_names,
        focusable = true,
        style = 'minimal',
        border = 'rounded',
    }
    if window_config.height > 0 then
        window = api.nvim_open_win(buffer, true, window_config)

        -- Disallow modifications of the action names
        api.nvim_command('setlocal nomodifiable')

        -- Highlight the line of the cursor
        api.nvim_command('setlocal cursorline')
        api.nvim_command('highlight CursorLine gui=bold,italic guibg=NONE')

        -- Cancel when buffer is no longer focused
        api.nvim_command('autocmd BufLeave <buffer> '..cancel_command)
    end
end

local function query_user()
    if actions == nil then return end

    local action_names = {}
    for i, action in ipairs(actions) do
        action_names[i] = i .. ': ' .. action.title
    end

    open_query_window(action_names)
end

local function code_action(err, result)
    if err ~= nil then
        error('failed to perform code action: ' .. err.message) 
    end

    if result == nil or not next(result) then return end

    actions = result

    query_user()
end

function M.on_attach(config)
    CONFIG = vim.tbl_extend('force', CONFIG, config or {})

    vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(
        code_action, CONFIG
    )
end

return M

