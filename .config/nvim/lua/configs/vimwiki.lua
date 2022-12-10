local function setup()
    vim.g.vimwiki_list = {{
        path = '~/Documents/dev/otpk/optk/wiki',
        path_html = '~/Documents/dev/otpk/optk/wiki/dist',
        syntax = 'markdown',
        ext = '.md',
        template_path = '',
        custom_wiki2html = 'vimwiki_markdown',
    }}
    vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}
    vim.g.vimwiki_customwiki2html = 'vimwiki_markdown'
    vim.g.vimwiki_markdown_link_ext = 1
end


return {
    packages = function(use)
        use({
            "vimwiki/vimwiki",
        })
    end,
    setup = setup,
    keybindings = function(bindkey)
    end,
}
