return {
	--"davidhalter/jedi-vim",
	--"preservim/nerdtree",
	--"sukima/xmledit",
	-- { "andymass/vim-matchup", ft = { "xml", "html", "python3" } },
	-- "prabirshrestha/vim-lsp",
	-- { "vim-autoformat/vim-autoformat", ft = "python" },
	-- "skywind3000/asyncrun.vim",
    {"neovim/nvim-lspconfig",
        dependencies = "netmute/ctags-lsp.nvim",
        config = function()
            require("lspconfig").ctags_lsp.setup({
               filetypes = { "c,h,cc,cpp,hh,hpp" }, -- Or whatever language you want to use it for
            })
        end,
    } ,
	--{ "valloric/youcompleteme", ft = "python" },
	{ "airblade/vim-gitgutter", cmd = "GitGutterEnable" },
	-- "BurntSushi/ripgrep",
	-- "preservim/nerdcommenter",
    {"vimwiki/vimwiki", config = function ()
        vim.g.vimwiki_list={{ path = '~/doc/vimwiki', syntax = 'markdown', ext = 'vimwiki'}}
    end
    },
	"dhananjaylatkar/cscope_maps.nvim",
	"svermeulen/vimpeccable",
    {'jakemason/ouroboros', dependencies = "nvim-lua/plenary.nvim" },
      -- {
        -- "doxnit/cmp-luasnip-choice",
        -- config = function()
          -- require("cmp_luasnip_choice").setup({
            -- auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
          -- })
        -- end,
      -- },
      --[[ {
          dir=vim.fn.expand("$HOME").."/repos/neovim_plugins/buffermod",
          --"RTO6000/buffermod",  -- Der Pfad zu deinem lokalen Plugin
          config = function()
            -- Deine Konfiguration für das lokale Plugin
            require('buffermod').setup({
                open_all_files = true,
                patterns = {
                    {
                        mapping = {
                            tp = "/home/rto/repos/mpu/pools/intern",
                            kp = "/home/rto/repos/mpu/pools/intern",
                            vp = "/home/rto/repos/mpu/ts_validation_mpu/pool/vp"
                        },
                        regex = "[%w%_%.]+%.[%w%_]+%-tc[%w%_]+",
                        rename = function(str,pattern_table)
                            local delimiter = "%."
                            local pool = string.match(str, "^(.-)%.")
                            local new_str=""
                            str= string.gsub(str,"%.","%/")
                            new_str = string.gsub(str,'-',"%/tc%/")
                            new_str = new_str:gsub(pool,pattern_table.mapping[pool],1)
                            return new_str
                        end
                    }
                }
            })
          end
    }, ]]
    --{
    --    dir=vim.fn.expand("$HOME").."/repos/neovim_plugins/jira.nvim",
    --    config = function()
    --        require('jira').setup({})
    --    end
    --},
    -- {"paulkass/jira-vim",},
    --"mechatroner/rainbow_csv"
    --"chrisbra/csv.vim"
    --[[ {
      "hat0uma/csvview.nvim",
      ---@module "csvview"
      ---@type CsvView.Options
      opts = {
        parser = { comments = { "#", "//" } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    }, ]]
    --{"tanvirtin/monokai.vim"},
    --[[ { 'SuperBo/fugit2.nvim',
        build = false,
        opts = {
            width = 100,
        },
        dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
            {
                'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
                dependencies = { 'stevearc/dressing.nvim' }
            },
        },
        cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
        keys = {
            { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' }
        }
    }, ]]
    --[[ {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    }, ]]
    -- {
        -- "MeanderingProgrammer/render-markdown.nvim",
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- },
-- {
  -- 'kid-icarus/jira.nvim',
  -- dependencies = {
    -- 'nvim-lua/plenary.nvim',
    -- 'nvim-telescope/telescope.nvim', -- optional
    -- 'folke/snacks.nvim', -- optional
  -- },
  -- opts = {
    -- jira_api = {
        -- domain='jira.sysgo.com',
        -- username='rto',
        -- token='',
    -- },
    -- use_git_branch_issue_id = true,
    -- git_trunk_branch = 'master', -- The main branch of your project
    -- git_branch_prefix = 'p', -- The prefix for your feature branches
  -- }, -- see configuration section
-- },
-- Using lazy.nvim
};
