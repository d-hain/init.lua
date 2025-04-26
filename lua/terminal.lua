local M = {}

--- @class NvimDotLuaConfig
--- @field build_command string The terminal command to execute when opening the terminal window.

--- @type number | nil
local float_term_buf = nil

--- @type number | nil
local float_term_win = nil

--- @type userdata | nil
local resize_timer = nil

--- @type number
local prev_columns = vim.o.columns

--- @type number
local prev_lines = vim.o.lines

--- @type string
local nvimdotlua_name = "/.nvim.lua"

function M.close_float_term()
    if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
        vim.api.nvim_win_close(float_term_win, true)
    end
    if float_term_buf and vim.api.nvim_buf_is_valid(float_term_buf) then
        vim.api.nvim_buf_delete(float_term_buf, { force = true })
    end

    if resize_timer then
        resize_timer:stop()
        resize_timer:close()
        resize_timer = nil
    end

    float_term_buf = nil
    float_term_win = nil
end

--- @param path string | nil
--- @return boolean # If the file exists
function M.check_nvimdotlua(path)
    if not path or path == "" then
        path = vim.fn.getcwd() .. nvimdotlua_name
    end

    return vim.fn.filereadable(path) == 1
end

--- @return NvimDotLuaConfig | nil
function M.load_project_nvimdotlua()
    local path = vim.fn.expand(vim.fn.getcwd() .. nvimdotlua_name)

    if M.check_nvimdotlua(path) then
        local ok, config = pcall(dofile, path)
        if ok and type(config) == "table" and config.build_command then
            return config
        end
    end

    return nil
end

--- @param cmd string | nil Optional command to run when the terminal is opened.
function M.open_float_term(cmd)
    -- If already open, do nothing
    if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
        vim.api.nvim_set_current_win(float_term_win)
        return
    end

    -- Create buffer
    float_term_buf = vim.api.nvim_create_buf(false, true)

    -- Create window
    local function window_opts()
        local width = math.floor(vim.o.columns * 0.5)
        local height = math.floor(vim.o.lines * 0.5)
        return {
            relative = "editor",
            width = width,
            height = height,
            col = math.floor((vim.o.columns - width) / 2),
            row = math.floor((vim.o.lines - height) / 2),
            border = "rounded",
            style = "minimal",
        }
    end
    float_term_win = vim.api.nvim_open_win(float_term_buf, true, window_opts())

    -- Open Terminal and run specified command or make if none was specified
    vim.fn.termopen(vim.o.shell)
    if cmd then
        vim.api.nvim_chan_send(vim.b.terminal_job_id, cmd .. "\n")
    elseif M.check_nvimdotlua() then
        local nvimdotlua = M.load_project_nvimdotlua()
        if nvimdotlua then
            vim.api.nvim_chan_send(vim.b.terminal_job_id, nvimdotlua.build_command .. "\n")
        end
    else
        vim.api.nvim_chan_send(vim.b.terminal_job_id, "make \n")
    end

    -- Auto-close when leaving
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = float_term_buf,
        callback = M.close_float_term,
        once = true,
    })

    -- Timer to watch terminal size
    resize_timer = vim.uv.new_timer()
    resize_timer:start(100, 100, vim.schedule_wrap(function()
        -- Check if terminal size changed
        if vim.o.columns ~= prev_columns or vim.o.lines ~= prev_lines then
            prev_columns = vim.o.columns
            prev_lines = vim.o.lines

            -- Update floating window config
            if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
                vim.api.nvim_win_set_config(float_term_win, window_opts())
            end
        end
    end))
end

return M
