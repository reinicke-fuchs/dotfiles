return {
    {"hrsh7th/cmp-nvim-lsp" },
    {"hrsh7th/cmp-buffer" },
    {"hrsh7th/cmp-path" },
    {"hrsh7th/cmp-cmdline" },
    {"hrsh7th/nvim-cmp", dependencies= "quangnguyen30192/cmp-nvim-tags" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = "quangnguyen30192/cmp-nvim-ultisnips",
        config = function()
            require("cmp_nvim_ultisnips").setup{}
        end,
        requires = { "nvim-treesitter/nvim-treesitter" },
    },
};
