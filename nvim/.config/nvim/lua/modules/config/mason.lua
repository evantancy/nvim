local mason = safe_require('mason')
if not mason then
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
})

local mason_lspconfig = safe_require('mason-lspconfig')
if not mason_lspconfig then
    return
end
mason_lspconfig.setup{
    ensure_installed = { "lua_ls" },
}
