local M = {}
local api = vim.api
local CONFIG = {}

local buffer = nil
local window = nil

local function close_query_window()
    api.nvim_buf_delete(buf, { force = true })
    window = nil
    buf = nil
end

function M.query_user_done()
    if buffer == nil then return end

    local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
    close_query_window()

    if #lines ~= 1 then
        error('invalid number of lines: ' .. #lines)
    end

    vim.lsp.buf.rename(lines[1])
end

function M.query_user_cancel()
    if buffer == nil then return end
    close_query_window()
end

function M.query_user_cursor_moved()
    local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
    api.nvim_win_set_height(window, math.max(1, #lines))
end

local function query_user(previous_name)
    buffer = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(buffer, 0, 1, false, { previous_name })

    local done_command = "<cmd>lua require'renaming'.query_user_done()<CR>"
    api.nvim_buf_set_keymap(buffer, 'i', '<CR>', done_command .. "<ESC>", {})
    api.nvim_buf_set_keymap(buffer, 'n', '<CR>', done_command, {})

    local cancel_command = "<cmd>lua require'renaming'.query_user_cancel()<CR>"
    api.nvim_buf_set_keymap(buffer, 'n', '<ESC>', cancel_command, {})

    local window_config = {
        relative = 'cursor',
        anchor = 'SW',
        row = -2,
        col = -1,
        width = #previous_name + 16,
        height = 1,
        focusable = true,
        style = 'minimal',
        border = 'rounded',
    }
    window = api.nvim_open_win(buffer, true, window_config)

    -- 
    local moved_command = "lua require'renaming'.query_user_cursor_moved()"
    api.nvim_command("autocmd CursorMoved <buffer> "..moved_command)
    api.nvim_command("autocmd CursorMovedI <buffer> "..moved_command)
    
    -- cancel when buffer is no longer focused
    api.nvim_command("autocmd BufLeave <buffer> lua require'renaming'.query_user_cancel()")
end

local function get_word_under_cursor()
    return vim.call('expand', '<cword>')
end

function M.rename()
    local old_name = get_word_under_cursor()
    query_user(old_name)
end

function M.on_attach(config)
    CONFIG = vim.tbl_extend('force', CONFIG, config or {})
end

return M

