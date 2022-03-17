vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ./*.lua, ./lua/core/*.lua, ./lua/modules/config/*.lua source <afile> | PackerCompile
  augroup end
]])
