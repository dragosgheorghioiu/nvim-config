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

local function install_plugin(repo_url, plugin_name)
  local plugin_dir = ensure_plugin_dir()
  local install_path = plugin_dir .. plugin_name

  if vim.fn.isdirectory(install_path) == 1 then
    print("Plugin '" .. plugin_name .. "' already exists")
    return
  end

  local cmd = 'git clone "' .. repo_url .. '" "' .. install_path .. '"'
  print("Installing " .. plugin_name .. "...")

  local result = os.execute(cmd)
  if result then
    print("Successfully installed: " .. plugin_name)
  else
    print("Failed to install: " .. plugin_name)
  end
end

local function update_plugins()
  local plugin_dir = ensure_plugin_dir()

  local handle = vim.loop.fs_scandir(plugin_dir)
  if not handle then
    print("No plugins found in directory: " .. plugin_dir)
    return
  end

  print("Updating plugins...")
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end

    if type == "directory" then
      local plugin_path = plugin_dir .. name
      local git_dir = plugin_path .. "/.git"
      if vim.fn.isdirectory(git_dir) == 1 then
        print("Updating " .. name .. "...")
        local cmd = 'git -C "' .. plugin_path .. '" pull'
        local result = os.execute(cmd)
        if result then
          print("Successfully updated: " .. name)
        else
          print("Failed to update: " .. name)
        end
      else
        print("Skipping " .. name .. ": Not a Git repository")
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
  for _, v in pairs(plugins_list) do
    if v['callback'] ~= nil then
      v.callback(v.opts)
    end
  end
end

return {
  setup = setup_plugins,
}
