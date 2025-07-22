local function grep_cword()
  local builtin = require("telescope.builtin")
  local cword = vim.fn.expand("<cword>") -- Holt das aktuelle Wort unter dem Cursor
  builtin.live_grep({ default_text = cword }) -- Startet live_grep mit dem Wort als Such-Pattern
end

local function grep_visual_or_cword()
  local builtin = require("telescope.builtin")
  local text = vim.fn.getreg('"') -- Holt den aktuellen Text in der Registerauswahl
  if text == "" then
    text = vim.fn.expand("<cword>") -- Fallback: Nimm das Wort unter dem Cursor
  end
  builtin.live_grep({ default_text = text })
end
-- Keymappings für <C-j>
vim.api.nvim_set_keymap("i", "<C-j>", '<Esc>/<++><CR>"_c4l', { noremap = true, silent = true })

-- Fensterbewegung mit <C-h>, <C-j>, <C-k>, <C-l>
--vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<C-j>", '<Esc>/<++><CR>"_c4l', { noremap = true, silent = true })
-- Keymapping für Goyo
vim.api.nvim_set_keymap("n", "<leader>mid", ":Goyo | set linebreak<CR>", { noremap = true, silent = true })
--
-- Keymapping für geschweifte Klammern in Insert-Modus
vim.api.nvim_set_keymap("i", "{<CR>", "{<CR>}<C-o>O", { noremap = true, silent = true })
--
-- Keymappings
vim.api.nvim_set_keymap(
	"n",
	"<F5>",
	":setlocal spell spelllang=en_us<CR>:syntax spell toplevel<CR><C-l>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<F6>", ":set nospell<CR>", { noremap = true, silent = true })
-- Keymapping für ClangFormatAutoToggle
vim.api.nvim_set_keymap("n", "<Leader>fat", ":ClangFormatAutoToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>format", ":ClangFormatAutoToggle<CR>", { noremap = true, silent = true })
--
-- Telescope Keymappings
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Telescope  buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>frg", grep_cword)

vim.api.nvim_set_keymap("v", "<leader>frg", ":<C-u>lua grep_visual_or_cword()<CR>", { noremap = true, silent = true })
-- Alternatives mapping dafür.
-- vim.api.nvim_set_keymap("n", "<leader>fg", ":lua grep_cword()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fZ", ":lua print("..vim.fn.expand("<cword>")..")<CR>", { noremap = true, silent = true })

-- Navigation zwischen Buffern
vim.api.nvim_set_keymap("n", "<C-p>", ":bp<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":bn<CR>", { noremap = true, silent = true })

-- NERD Commenter Keybindings
vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>NERDCommenterInvert", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>NERDCommenterInvert", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>cm", "<Plug>NERDCommenterMinimal", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cm", "<Plug>NERDCommenterMinimal", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>ca", "<Plug>NERDCommenterAltDelims", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ca", "<Plug>NERDCommenterAltDelims", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>cy", "<Plug>NERDCommenterYank", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cy", "<Plug>NERDCommenterYank", { noremap = true, silent = true })


-- Autoformat Keybinding
vim.api.nvim_set_keymap("n", "<F7>", ":Autoformat<CR>", { noremap = true, silent = true })

--
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('buffer_manager.ui').toggle_quick_menu()<cr>", { noremap = true, silent = true })

vim.api.nvim_command([[
    autocmd FileType buffer_manager vnoremap J :m '>+1<CR>gv=gv
    autocmd FileType buffer_manager vnoremap K :m '<-2<CR>gv=gv
]])
vim.api.nvim_create_autocmd("FileType", {
	pattern = "buffer_manager",
	callback = function()
        vim.cmd("noremap <leader>s  :lua require'buffer_manager.ui'.save_menu_to_file()<CR>")
        vim.cmd("noremap <leader>l  :lua require'buffer_manager.ui'.load_menu_from_file()<CR>")
	end,
})

vim.api.nvim_set_keymap("n", "<leader>tc", ":OPENCURSOR<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>tc", ":OPENCURSOR<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>jv', '<cmd>Jira issue view<cr>', {})
-- clang-format Keymappings für bestimmte Dateitypen
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cxx", "cpp", "h", "hpp", "hxx", "objc" },
	callback = function()
		--vim.api.nvim_buf_set_keymap(0, "n", "<Leader>cf", ":<C-u>ClangFormat<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "v", "<Leader>cf", ":ClangFormat<CR>", { noremap = true, silent = true })
	end,
})
vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", { noremap = true, silent = true })

-- Tagbar Toggle
vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true })
--
-- Tagbar Toggle
vim.api.nvim_set_keymap("n", "<leader>x", ":TagbarOpenAutoClose<CR>", { noremap = true, silent = true })
-- Tagbar Toggle
vim.api.nvim_set_keymap("v", "<leader>x", ":TagbarOpenAutoClose<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cc", "cpp", "h", "hpp", "hh" },
	callback = function()
        vim.api.nvim_set_keymap("n", "<leader>sh", ":split | Ouroboros<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit | Ouroboros<CR>", { noremap = true, silent = true })
	end,
})
vim.api.nvim_create_autocmd({ "BufWritePre", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_set_keymap('i', '<F2>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ut", "<cmd>lua tags_picker()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tc",
                function() tc_picker("/home/rto/repos/mpu/pools/",
                {intern = "tp", kdev = "kp" }) end, { noremap = true, silent = true } )
vim.keymap.set(
  "n",
  "<leader>fh",
  require('telescope').extensions.picker_list.picker_list
)

--vim.g.NERDTreeMapUpdir='a'

-- greatest remap ever
vim.keymap.set("x", "P", [["_dP]])

-- isn't that just yank into clipboard?
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set('n', 'gp', function()
  return '`[' .. string.sub(vim.fn.getregtype(), 1, 1) .. '`]'
end, { expr = true, noremap = true })

--
local harpoon = require("harpoon")
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

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-S-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
---- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
-- NERDTree Find Keybinding
--vim.api.nvim_set_keymap("n", "<leader>r", ":Explore<cr>", { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<leader>r", ":Explore<cr>", { noremap = true, silent = true, expr=true })
-- vim.keymap.set("i", "<C-Y>", function()
--  return vim.fn.pumvisible() == 1 and "<C-n>" or vim.fn["UltiSnips#ExpandSnippetOrJump"]()
-- end, { expr = true, noremap = true })

vim.keymap.set("i", "<C-Y>", function()
  return vim.fn["UltiSnips#ExpandSnippetOrJump"]()
end, { expr = true, noremap = true })

function ToggleOil()
  local oil = require("oil")

  -- Check if the current buffer is an oil buffer
  if vim.bo.filetype == "oil" then
    vim.cmd("bd") -- Close the buffer
  else
    oil.open() -- Open oil
  end
end
-- Open it with :Oil or bind a key to open it in the current buffer
vim.keymap.set("n", "<leader>r", ToggleOil, { desc = "Open parent directory" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(args)
    vim.keymap.set("n", "<leader>cp", function()
      local oil = require("oil")
      local entry = oil.get_cursor_entry()
      if entry then
        print(entry)
        vim.fn.setreg("+", entry.path)
        print("Copied: " .. entry.path)
      else
        print("No entry under cursor")
      end
    end, { buffer = args.buf, desc = "Copy Oil entry path" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    vim.keymap.set("i", "<C-c>", function()
      return vim.fn["UltiSnips#ExpandSnippetOrJump"]()
    end, { expr = true, noremap = true, buffer = true })
  end,
})
