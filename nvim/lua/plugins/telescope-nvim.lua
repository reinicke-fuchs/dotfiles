return {
	{"nvim-telescope/telescope-media-files.nvim"},
    {"lpoto/telescope-docker.nvim"},
	{"nvim-lua/plenary.nvim"},
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.8",
        dependencies = {
            { "OliverChao/telescope-picker-list.nvim" },
        },
        config = function()
            require('telescope').setup({
            defaults = {
                layout_config = {
                    preview_cutoff = 0,
                    height = 0.9,
                    preview_height = 0.5,
                    horizontal = {
                      prompt_position = "top",     -- or "bottom" based on your preference
                      preview_width = 0.9,
                    },
                    vertical = {
                      mirror = true,               -- this flips the preview window to below
                    },
              },
              layout_strategy = 'vertical',    -- Use 'vertical' layout to position below
              sorting_strategy = "ascending",  -- Makes prompt stay on top
            },
            extensions = {
                -- NOTE: this setup is optional
                docker = {
                    -- These are the default values
                    theme = "ivy",
                    binary = "podman", -- in case you want to use podman or something
                    compose_binary = "podman compose",
                    buildx_binary = "docker buildx",
                    machine_binary = "docker-machine",
                    log_level = vim.log.levels.INFO,
                    init_term = "tabnew", -- "vsplit new", "split new", ...
                    -- NOTE: init_term may also be a function that receives
                    -- a command, a table of env. variables and cwd as input.
                    -- This is intended only for advanced use, in case you want
                    -- to send the env. and command to a tmux terminal or floaterm
                    -- or something other than a built in terminal.
                },
            },
        })
    end
    },
};
