local plugins_list = require("plugins.plugins_list")

local function get_plugin_path()
  local data_path = vim.fn.stdpath('data')
  return data_path .. '/site/pack/manual/start/'
end

local function ensure_plugin_dir()
  local plugin_path = get_plugin_path()
  vim.fn.mkdir(plugin_path, 'p')
  return plugin_path
end

-- TODO: should open a floating window with the details
-- TODO: should have a build feature for plugins like blink
local function install_plugin(repo_url, plugin_name)
  local plugin_dir = ensure_plugin_dir()
  local install_path = plugin_dir .. plugin_name

  if vim.fn.isdirectory(install_path) == 1 then
    vim.notify("Plugin '" .. plugin_name .. "' already exists")
    return
  end

  local cmd = 'git clone "' .. repo_url .. '" "' .. install_path .. '"'
  vim.notify("Installing " .. plugin_name .. "...")

  local result = os.execute(cmd)
  if result then
    vim.notify("Successfully installed: " .. plugin_name)
  else
    vim.notify("Failed to install: " .. plugin_name)
  end
end

local function update_plugins()
  local plugin_dir = ensure_plugin_dir()

  local handle = vim.loop.fs_scandir(plugin_dir)
  if not handle then
    vim.notify("No plugins found in directory: " .. plugin_dir)
    return
  end

  vim.notify("Updating plugins...")
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end

    if type == "directory" then
      local plugin_path = plugin_dir .. name
      local git_dir = plugin_path .. "/.git"
      if vim.fn.isdirectory(git_dir) == 1 then
        vim.notify("Updating " .. name .. "...")
        local cmd = 'git -C "' .. plugin_path .. '" pull'
        local result = os.execute(cmd)
        if result then
          vim.notify("Successfully updated: " .. name)
        else
          vim.notify("Failed to update: " .. name)
        end
      else
        vim.notify("Skipping " .. name .. ": Not a Git repository")
      end
    end
  end
end


vim.api.nvim_create_user_command('PluginInstall', function()
  for k, v in pairs(plugins_list) do
    install_plugin(v.url, k)
  end
end, {
  desc = "Installs plugins from the plugins list"
})

vim.api.nvim_create_user_command('PluginUpdate', function()
  update_plugins()
end, {
  desc = "Updates plugins from the plugins list"
})


local function setup_plugins()
  local plugin_dir = get_plugin_path()
  local plugin_dir_stat = vim.loop.fs_stat(plugin_dir)
  if plugin_dir_stat == nil then
    vim.notify("Could not find plugins dir. Should run :PluginInstall")
    return
  end

  for plugin_name, plugin_opts in pairs(plugins_list) do
    local install_path = plugin_dir .. plugin_name
    local stat = vim.loop.fs_stat(install_path)

    if stat == nil then
      vim.notify("Could not find plugin: " .. plugin_name)
    elseif plugin_opts.callback then
      plugin_opts.callback(plugin_opts.opts)
    end
  end
end

return {
  setup = setup_plugins,
}
