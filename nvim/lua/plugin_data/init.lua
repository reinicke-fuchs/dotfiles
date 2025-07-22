-- lazy.nvim Setup

require("monokai-nightasty").load({})
vim.cmd("colorscheme monokai-nightasty")
--vim.cmd("colorscheme sonokai")
-- Airline Theme
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.cmd("AirlineTheme badwolf")
	end,
})

require("telescope").setup(

)
-- Load the docker telescope extension
require("telescope").load_extension("docker")
--local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(), -- Gehe zum nächsten Vorschlag
    ['<C-p>'] = cmp.mapping.select_prev_item(), -- Gehe zum vorherigen Vorschlag
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Vorschlag bestätigen
--    ['<C-Space>'] = cmp.mapping(
            -- function(fallback)
                -- cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            -- end,{ "i", "s"}),
    ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end,
          { "i", "s"}
    ),
  },
  sources = {
    { name = 'nvim_lsp' }, -- LSP-Quelle
    { name = 'tags' }, -- LSP-Quelle
    { name = 'buffer' },   -- Buffer-Quelle
    { name = 'path' },     -- Datei- und Pfad-Quelle
    { name = 'ultisnips' },  -- Snippet-Quelle
  }
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
 require('lspconfig').ltex.setup {
  on_attach = function()
    -- ...
    require('ltex_extra').setup {
      -- This is where your dictionary will be stored! Replace this path with
      -- whatever you want!
      path = vim.fn.expand '~' .. '/.config/nvim/ltex',
    }
  end,
  settings = {
    ltex = {
        additionalRules = {
            enablePickyRules = true,
        },
    },
  },
  filetypes = {  'text', 'tex', 'gitcommit' },
  flags = { debounce_text_changes = 300 },
}

require('lspconfig').pyright.setup({
  on_attach = function(client, bufnr)
    -- Keymaps für LSP
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi',function()
        vim.cmd('normal! m`')  -- Position speichern
        vim.lsp.buf.implementation()
    end, bufopts)
    vim.keymap.set('n', 'gd', function()
        vim.cmd('normal! m`')  -- Position speichern
        vim.lsp.buf.definition()
    end, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(), -- Autocompletion-Fähigkeiten
  virtual_text = true,
})
require 'lspconfig'.zls.setup({

})
require("lspconfig").ctags_lsp.setup({
    filetypes = { "c,h,cc,cpp,hh,hpp" }, -- Or whatever language you want to use it for
})
-- Buffer Manager
require("buffer_manager").setup({
    line_keys = "1234567890",
    select_menu_item_commands = {
      edit = {
        key = "<CR>",
        command = "edit"
      }
    },
    focus_alternate_buffer = false,
    short_file_names = false,
    short_term_names = false,
    loop_nav = true,
    highlight = "",
    win_extra_options = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    format_function = nil,
    order_buffers = nil,
    show_indicators = nil,
})
require("bufferline").setup{}
--require("luasnip").filetype_extend("vimwiki", {"markdown"})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c","python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require("nvim-python-repl").setup(
        {
            spawn_command={
                python="ipython3"
            }
        }
    )

vim.keymap.set("n", "<leader>es", function() require('nvim-python-repl').send_statement_definition() end, { desc = "Send semantic unit to REPL"})

vim.keymap.set("v", "<leader>es", function() require('nvim-python-repl').send_visual_to_repl() end, { desc = "Send visual selection to REPL"})

vim.keymap.set("n", "<leader>eb", function() require('nvim-python-repl').send_buffer_to_repl() end, { desc = "Send entire buffer to REPL"})

vim.keymap.set("n", "<leader>et", function() require('nvim-python-repl').toggle_execute() end, { desc = "Automatically execute command in REPL after sent"})

vim.keymap.set("n", "<leader>ev", function() require('nvim-python-repl').toggle_vertical() end, { desc = "Create REPL in vertical or horizontal split"})

vim.fn["airline#parts#define"] ('maxcolnr', {raw= '-%{col(\"$\")}', accent= 'bold'})
vim.cmd("let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%'.g:airline_symbols.space, 'linenr', 'maxlinenr', 'colnr', 'maxcolnr'])")

--vim.keymap.set("n", "<leader>", function() require('nvim-python-repl').open_repl() end, { desc = "Opens the REPL in a window split"})
require("renamer").setup()
require'ultimate-autopair'.setup{}
require("plugin_data.tags")

require('overlength').setup({
   -- Overlength highlighting enabled by default
  enabled = true,

  -- Colors for OverLength highlight group
  colors = {
    ctermfg = 'red',
    ctermbg = 'lightgrey',
    fg = '#FF0000', -- RED
    bg = '#3c3836',
  },

  -- Mode to use textwidth local options
  -- 0: Don't use textwidth at all, always use config.default_overlength.
  -- 1: Use `textwidth, unless it's 0, then use config.default_overlength.
  -- 2: Always use textwidth. There will be no highlighting where
  --    textwidth == 0, unless added explicitly
  textwidth_mode = 1,
  -- Default overlength with no filetype
  default_overlength = 80,
  -- How many spaces past your overlength to start highlighting
  grace_length = 1,
  -- Highlight only the column or until the end of the line
  highlight_to_eol = true,

  -- List of filetypes to disable overlength highlighting
  disable_ft = { 'qf', 'help', 'man', 'checkhealth', 'lazy', 'packer', 'NvimTree', 'Telescope', 'WhichKey', 'xml' },
})

require("oil").setup({
    columns = {
        "icon",
        "permissions",
    }
})

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED
--
local function get_git_subdir_path()

  local file_dir = vim.loop.cwd()

  -- Get Git root directory
  local git_root = vim.fn.systemlist('git -C "' .. file_dir .. '" rev-parse --show-toplevel')[1]

  if not git_root or git_root == '' or git_root:match('fatal') then
    return nil -- Not in a Git repo
  end

  -- Normalize paths (handle Windows vs Unix and trailing slashes)
  -- local function normalize(path)
    -- return path:gsub('\\', '/'):gsub('/+$', '')
  -- end
--
  -- file_dir = normalize(file_dir)
  -- git_root = normalize(git_root)

  -- Return the file_dir if it's inside the Git root but not equal
  if file_dir:sub(1, #git_root) == git_root or file_dir == git_root then
    return git_root
  end

  return nil
end

local harpoon = require('harpoon')
harpoon:setup({
    settings = {
        key = function()
           a = get_git_subdir_path() or vim.loop.cwd()
           -- a = vim.loop.cwd()
           -- print("key called ", a==get_git_subdir_path())
           return a
        end,
        save_on_toggle = true,
        save_on_ui_close = true,
    }
})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
vim.api.nvim_create_user_command("ShowGitSubdir", function()
  local path = get_git_subdir_path()
  if path then
    print("Subdirectory path: " .. path)
  else
    print("Not in a Git subdirectory.")
  end
end, {})

--require('bamboo').load()
