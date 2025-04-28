local M = {}

--- @class NvimDotLuaConfig
--- @field build_command string The terminal command to execute when opening the terminal window.

--- @type number | nil
local term_buf = nil

--- @type number | nil
local term_win = nil

--- @type userdata | nil
local float_resize_timer = nil

--- @type number | nil
local float_autoclose_autocmd_id = nil

--- @type number
local prev_columns = vim.o.columns

--- @type number
local prev_lines = vim.o.lines

--- @type string
local nvimdotlua_name = "/.nvim.lua"

function M.close_term_win()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
    end

    if float_resize_timer then
        float_resize_timer:stop()
        float_resize_timer:close()
        float_resize_timer = nil
    end

    term_win = nil
end

function M.close_term_buf()
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.api.nvim_buf_delete(term_buf, { force = true })
    end

    term_buf = nil
end

function M.close_float_term()
    M.close_term_win()
    M.close_term_buf()
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
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_set_current_win(term_win)
        return
    end

    -- Create buffer
    term_buf = vim.api.nvim_create_buf(false, true)

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
    term_win = vim.api.nvim_open_win(term_buf, true, window_opts())

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
    float_autoclose_autocmd_id = vim.api.nvim_create_autocmd("BufLeave", {
        buffer = term_buf,
        callback = M.close_float_term,
        once = true,
    })

    -- Timer to watch terminal size
    float_resize_timer = vim.uv.new_timer()
    float_resize_timer:start(100, 100, vim.schedule_wrap(function()
        -- Check if terminal size changed
        if vim.o.columns ~= prev_columns or vim.o.lines ~= prev_lines then
            prev_columns = vim.o.columns
            prev_lines = vim.o.lines

            -- Update floating window config
            if term_win and vim.api.nvim_win_is_valid(term_win) then
                vim.api.nvim_win_set_config(term_win, window_opts())
            end
        end
    end))
end

function M.float_to_split_term()
    if not (term_buf and vim.api.nvim_buf_is_valid(term_buf)) then
        print("No open floating terminal!")
        return
    end

    -- Put the terminal in a horizontal split at the bottom of neovim
    vim.cmd("belowright split")
    -- Make the split 35% of the total height
    vim.cmd("resize " .. math.floor(vim.o.lines * 0.35))

    -- Floating window buffer -> split window
    local split_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(split_win, term_buf)

    -- Close floating terminal and set the new one
    M.close_term_win()
    term_win = split_win

    -- Do NOT auto-close when leaving
    vim.api.nvim_del_autocmd(float_autoclose_autocmd_id)
end

return M
