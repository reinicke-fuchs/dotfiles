return {
    {
        "forest-nvim/sequoia.nvim",
        lazy = false
    },
    { 'sainnhe/sonokai' },
    {"Skardyy/makurai-nvim"},
    {'marko-cerovac/material.nvim'},
    {'mellow-theme/mellow.nvim'},
    {
      "polirritmico/monokai-nightasty.nvim",
      lazy = false,
      priority = 1000,
      dark_style_background="dark"
    },
    {
      'ribru17/bamboo.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        require('bamboo').setup {
            --style = 'multiplex'
            style = 'vulgaris'
          -- optional configuration here
        }
      end,
    },
}
