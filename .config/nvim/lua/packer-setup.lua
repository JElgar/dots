local function setup()
    -- Bootstrap
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
            install_path })
        vim.cmd [[packadd packer.nvim]]
    end

    local _, packer = pcall(require, "packer")

    -- Popup window for Packer
    packer.init {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    return packer_bootstrap
end

return {
    setup = setup
}
