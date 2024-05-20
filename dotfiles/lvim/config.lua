vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.timeoutlen = 1000

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "catppuccin-macchiato"
lvim.transparent_window = true

-- https://www.lunarvim.org/docs/beginners-guide/keybinds-overview
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w!<cr>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Run :TSUpdate
lvim.builtin.treesitter.ensure_installed = {
    "bash", "javascript", "json", "lua", "python", "typescript", "tsx", "yaml"
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Run :LvimCacheReset after modified
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.automatic_configuration.skipped_servers =
    vim.tbl_filter(function(server) return server ~= "pyright" end,
                   lvim.lsp.automatic_configuration.skipped_servers)

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {command = "ruff", filetypes = {"python"}},
    {command = "lua-format", filetypes = {"lua"}}
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {{command = "ruff", filetypes = {"python"}}}

-- https://www.lunarvim.org/docs/configuration/plugins
-- :LvimSyncCorePlugins
lvim.plugins = {
    {"catppuccin/nvim", name = "catppuccin", opts = {flavour = "macchiato"}},
    {"folke/tokyonight.nvim"}, {
        "github/copilot.vim",
        event = "VeryLazy",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            vim.g.copilot_filetypes = {}
        end
    }, {"folke/trouble.nvim", cmd = "TroubleToggle"}, {"tpope/vim-surround"}, {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        init = function()
            vim.g.indentLine_enabled = 1
            vim.g.indent_blankline_char = "▏"
            vim.g.indent_blankline_filetype_exclude = {
                "help", "terminal", "dashboard"
            }
            vim.g.indent_blankline_buftype_exclude = {"terminal"}
            vim.g.indent_blankline_show_trailing_blankline_indent = false
            vim.g.indent_blankline_show_first_indent_level = false
        end
    }
}

-- Trouble.nvim
lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = {"<cmd>TroubleToggle<cr>", "trouble"},
    w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace"},
    d = {"<cmd>TroubleToggle document_diagnostics<cr>", "document"},
    q = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
    l = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
    r = {"<cmd>TroubleToggle lsp_references<cr>", "references"}
}

-- github/copilot.vim
-- Tab	Accept the suggestion
-- Ctrl-]	Dismiss the current suggestion
-- Alt-[	Cycle to the next suggestion
-- Alt-]	Cycle to the previous suggestion
-- <M> is alt
-- <C> is ctrl
local cmp = require "cmp"
lvim.builtin.cmp.mapping["<M-t>"] = function(fallback)
    cmp.mapping.abort()
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
        fallback()
    end
end

-- Tab switch buffer
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
