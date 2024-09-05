local status, lualine = pcall(require, 'lualine')
if not status then
    return
end

local status, auto_session = pcall(require, 'auto-session')
if status then
    -- global variables
    status2, auto_session_library = pcall(require, 'auto-session-library')
    lib_status, auto_session_lib = pcall(require, 'auto-session.lib')
end

function session_or_filename()
    if lib_status then
        return auto_session_lib.current_session_name
    end
    return {
        'filename',
        file_status = false,
        path = 0, -- 0: filename only, 1: relative, 2: absolute
        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        symbols = {
            modified = '[+]', -- Text to show when the file is modified.
            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.,
        },
    }
end

lualine.setup({
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        -- REQUIRES neovim >=0.7
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { session_or_filename() },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = { 'location', 'progress' },
    },
    tabline = {},
    extensions = {},
})
