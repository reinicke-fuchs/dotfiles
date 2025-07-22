local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local default_tags="/home/rto/.cache/nvim/tags," .. vim.o.tags
local pikeostags="/home/rto/tags_dir/arm_v8r/pikeostags"
local library_tags="/home/rto/tags_dir/nocert-mpu/1.1/libtags"

vim.o.tags=default_tags..","..pikeostags..","..library_tags

function libtags_picker()
  pickers.new({}, {
    prompt_title = "Tags",
    finder = finders.new_oneshot_job(
      { "find","/home/rto/tags_dir", "-type", "f" ,"-name" , "libtags"},
      {
        entry_maker = function(line)
          return {
            value = line,
            display = line,
            ordinal = line,
          }
        end,
      }
    ),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.o.tags=default_tags..selection.value
        actions.close(prompt_bufnr)
        print(selection.value)
        library_tags=selection.value
        vim.cmd.set("tags="..default_tags..","..pikeostags..","..library_tags)
      end)
      return true
    end,
  }):find()
end

function pikeos_tags_picker()
  pickers.new({}, {
    prompt_title = "Tags",
    finder = finders.new_oneshot_job(
      { "find","/home/rto/tags_dir", "-type", "f" ,"-name", "pikeostags" },
      {
        entry_maker = function(line)
          return {
            value = line,
            display = line,
            ordinal = line,
          }
        end,
      }
    ),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.o.tags=default_tags..selection.value
        actions.close(prompt_bufnr)
        print(selection.value)
        pikeostags=selection.value..","
        vim.cmd.set("tags="..default_tags..","..pikeostags..","..library_tags)
      end)
      return true
    end,
  }):find()
end

function tags_picker()
  pickers.new({}, {
    prompt_title = "Tags",
    finder = finders.new_table({
        results = {
            { name = "Pikeos Tags" , action= pikeos_tags_picker },
            { name = "Library Tags" , action= libtags_picker },
            { name = "Set TC" , action= tc_picker }
        },
        entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection == nil then
			return
		end
        local value = selection.value
		actions.close(prompt_bufnr)
        value.action()
      end)
      return true
    end,
  }):find()
end

function extract_pool_and_rename(str, mapping)
    local pool = string.match(str, "^(.-)%/")
    if pool == nil then
       return "nil"
    end
    if mapping[pool] ~= nil then
        return str:gsub(pool, mapping[pool])
    end
    return str
end

function tc_picker(directory, mapping)
  pickers.new({}, {
    prompt_title = "TC",
    finder = finders.new_oneshot_job(
      {"sh", "-c",  "cd "..directory.." && find . -type f -name tc.xml -printf '%P\n' | xargs dirname"},
      {
        entry_maker = function(line)
          return {
            value = directory..'/'..line,
            display = extract_pool_and_rename(line, mapping):gsub("%/tc",""):gsub("%/","%."),
            ordinal = line,
          }
        end,
      }
    ),
    sorter = sorters.get_fuzzy_file(),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection == nil then
		    actions.close(prompt_bufnr)
			return
		end
        local value = selection.value
		actions.close(prompt_bufnr)
        vim.cmd("cd "..value)
      end)
      return true
    end,
  }):find()
end
