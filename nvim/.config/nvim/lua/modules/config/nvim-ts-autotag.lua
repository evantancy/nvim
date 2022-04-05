return function()
    local nvim_ts_autotag = safe_require('nvim-ts-autotag')
    if not nvim_ts_autotag then
        return
    end
    nvim_ts_autotag.setup({
        autotag = {
            enable = true,
            filetypes = {
                'html',
                'javascript',
                'typescript',
                'javascriptreact',
                'typescriptreact',
                'svelte',
                'vue',
                'tsx',
                'jsx',
                'rescript',
                'xml',
                'php',
                'markdown',
                'glimmer',
                'handlebars',
                'hbs',
            },
            skip_tags = {
                'area',
                'base',
                'br',
                'col',
                'command',
                'embed',
                'hr',
                'img',
                'slot',
                'input',
                'keygen',
                'link',
                'meta',
                'param',
                'source',
                'track',
                'wbr',
                'menuitem',
            },
        },
    })
end
