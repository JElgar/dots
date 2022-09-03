local function setup()
    vim.g.vimwiki_list = {{path = '~/Documents/wiki', syntax = 'markdown', ext = '.md'}}
end


return {
    packages = function(use)
        use({
            "vimwiki/vimwiki",
            config = setup
        })
    end,
    keybindings = function(bindkey)
    end,
}
