local function setup()
    vim.g.vimwiki_list = {{
        path = '~/Documents/dev/otpk/optk/wiki',
        path_html = '~/Documents/dev/otpk/optk/wiki/dist',
        syntax = 'markdown',
        ext = '.md',
        custom_wiki2html = '~/Documents/optk/optk/wiki/build.sh',
    }}
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
