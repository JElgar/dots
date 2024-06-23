local function make_defaults()
    return {
        mappings = {
            i = {
                ["jk"] = require('telescope.actions').close,
            },
        },
        prompt_prefix = " 🔭 ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    }
end

local function setup()
    local telescope = require("telescope")
    telescope.setup({
        defaults = make_defaults(),
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {}
            }
        },
        pickers = {
            find_files = {
                hidden = true,
            }
        },
    })

    local extensions = { "themes", "terms", "flutter" }

    pcall(function()
        for _, ext in ipairs(extensions) do
            telescope.load_extension(ext)
        end
    end)

    require("telescope").load_extension("ui-select")
end

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.7',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
    init = setup,
    keys = {
        { "gr",         "<cmd> Telescope lsp_references<cr>",                     mode = "n" },
        { "<leader>ff", require('telescope.builtin').find_files, mode = "n" },
        { "<leader>fg", require('telescope.builtin').live_grep,  mode = "n" },
        { "<leader>fb", require('telescope.builtin').buffers,    mode = "n" },
        { "<leader>fh", require('telescope.builtin').help_tags,  mode = "n" },
    }
}
