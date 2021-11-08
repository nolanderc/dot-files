local M = {}
local api = vim.api
local CONFIG = {
    follow_cursor = true,
}

local window = nil
local visible = false

local function open_window(width)
    local buf = api.nvim_create_buf(false, true)
    local config = { 
        relative = 'cursor',
        anchor = 'SW',
        row = 0,
        col = 0,
        width = width,
        height = 1,
        focusable = false,
        style = 'minimal',
        border = 'none',
    }
    return api.nvim_open_win(buf, false, config)
end

local function close_window()
    visible = false
    if window ~= nil then
        api.nvim_win_close(window, false)
        window = nil
    end
end

local previous_label = nil

local function display_label(label)
    if not visible then return end

    if not CONFIG.follow_cursor then
        -- if we had the same label, keep the window where it was
        if window ~= nil and label == previous_label then return end
        previous_label = label
    end

    if window == nil then
        window = open_window(#label)
    else
        api.nvim_win_set_config(window, { 
                relative = 'cursor',
                row = 0,
                col = 0,
                width = #label,
            })
    end

    local buf = api.nvim_win_get_buf(window)
    api.nvim_buf_set_lines(buf, 0, 1, false, { label })
end

local function signature_help(err, method, result, client_id, bufnr, config)
    if err ~= nil then
        error('failed to display signature: ' .. err) 
    end

    if result == nil then
        close_window()
        return
    end

    print("result:", vim.inspect(result))

    local signature = result.signatures[1 + (result.activeSignature or 0)]
    if signature == nil then return end

    print(vim.inspect(signature))

    local active_param = result.activeParameter or signature.active_parameter or signature.activeParameter or 1
    local parameter = signature.parameters[1+active_param]
    if parameter == nil then return end

    local label = parameter.label
    if label == nil then return end

    display_label(label)
end

function M.on_cursor_moved()
    visible = true
    vim.lsp.buf.signature_help()
end

function M.on_insert_enter()
    visible = true
    vim.lsp.buf.signature_help()
end

function M.on_insert_leave()
    close_window()
end

function M.on_attach(config)
    vim.cmd("autocmd CursorMovedI <buffer> lua require'signatures'.on_cursor_moved()")
    vim.cmd("autocmd InsertEnter <buffer> lua require'signatures'.on_insert_enter()")
    vim.cmd("autocmd InsertLeave <buffer> lua require'signatures'.on_insert_leave()")

    CONFIG = vim.tbl_extend('force', CONFIG, config or {})

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(signature_help, CONFIG)
end

return M

