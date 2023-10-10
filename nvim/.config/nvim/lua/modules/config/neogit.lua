local status, neogit = pcall(require, 'neogit')
if not status then
    return
end

neogit.setup({
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    commit_popup = {
        kind = 'split',
    },
    -- Change the default way of opening neogit
    kind = 'tab',
    -- customize displayed signs
    signs = {
        -- { CLOSED, OPENED }
        section = { '>', 'v' },
        item = { '>', 'v' },
        hunk = { '', '' },
    },
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    integrations = { diffview = true },
})
