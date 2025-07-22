return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "folke/snacks.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/obsidian/personal",
        },
        {
          name = "work",
          path = "~/Documents/obsidian/work",
        },
      },
      daily_notes = {
        folder = "dailies",
      },
      completion = {
        -- Enables completion using nvim_cmp
        nvim_cmp = true,
        -- Enables completion using blink.cmp
        blink = false,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,
      picker = {
        name = "snacks.pick",
      },
      ui = {
        -- use render-markdown instead for these
        enable = false,
        checkboxes = {},
        bullets = {},
        external_link_icon = {},
      },
    },
}

