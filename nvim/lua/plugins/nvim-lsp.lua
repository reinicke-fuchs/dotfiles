return {"neovim/nvim-lspconfig",
        dependencies = "netmute/ctags-lsp.nvim",
        config = function()
            require("lspconfig").ctags_lsp.setup({
               filetypes = { "c,h,cc,cpp,hh,hpp" }, -- Or whatever language you want to use it for
            })
        end,
    };
