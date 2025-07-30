local plugins_list = require("plugins.plugins_list")
local plugin_log = require("plugins.plugin_log")

local done = 0
local total = 0

local function set_total_plugins()
  for _ in pairs(plugins_list) do
    total = total + 1
  end
  plugin_log.update_progress(done, total)
end

local function get_plugin_path()
  local data_path = vim.fn.stdpath('data')
  return data_path .. '/site/pack/manual/start/'
end

local function ensure_plugin_dir()
  local plugin_path = get_plugin_path()
  vim.fn.mkdir(plugin_path, 'p')
  return plugin_path
end

local function install_plugin(plugin_details, plugin_name)
  local plugin_dir = ensure_plugin_dir()
  local install_path = plugin_dir .. plugin_name

  if vim.fn.isdirectory(install_path) == 1 then
    vim.schedule(function()
      done = done + 1
      plugin_log.update_progress(done, total)
      plugin_log.log("Plugin '" .. plugin_name .. "' already exists")
    end)
    return
  end

  vim.schedule(function()
    plugin_log.log("Installing " .. plugin_name .. "...")
  end)

  local clone_cmd = { "git", "clone", plugin_details.url, install_path }
  vim.system(clone_cmd, {}, function(clone_result)
    vim.schedule(function()
      if clone_result.code == 0 then
        plugin_log.log("Successfully installed: " .. plugin_name)

        if plugin_details.build then
          vim.schedule(function()
            plugin_log.log("Building " .. plugin_name .. "...")
          end)
          local build_cmd = vim.fn.split(plugin_details.build, " ")
          vim.system(build_cmd, { cwd = install_path }, function(build_result)
            vim.schedule(function()
              if build_result.code == 0 then
                done = done + 1
                plugin_log.update_progress(done, total)
                plugin_log.log("Successfully built: " .. plugin_name)
              else
                plugin_log.log("Build failed: " .. plugin_name)
                if build_result.stderr then
                  plugin_log.log(build_result.stderr)
                end
              end
            end)
          end)
        else
          done = done + 1
          plugin_log.update_progress(done, total)
        end
      else
        plugin_log.log("Failed to install: " .. plugin_name)
        if clone_result.stderr then
          plugin_log.log(clone_result.stderr)
        end
      end
    end)
  end)
end

local function update_plugins()
  local plugin_dir = get_plugin_path()
  if vim.fn.isdirectory(plugin_dir) == 0 then
    vim.notify("No plugins installed. Please install them by running :PluginInstall")
    return
  end

  local handle = vim.loop.fs_scandir(plugin_dir)
  if not handle then
    vim.notify("No plugins found in directory: " .. plugin_dir)
    return
  end

  done = 0
  set_total_plugins()
  plugin_log.update_progress(done, total)
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end

    if type == "directory" then
      local plugin_path = plugin_dir .. name
      local git_dir = plugin_path .. "/.git"
      if vim.fn.isdirectory(git_dir) == 1 then
        plugin_log.log("Updating " .. name .. "...")
        vim.system({ 'git', 'pull' }, { cwd = plugin_path }, function(update_result)
          vim.schedule(function()
            if update_result.code == 0 then
              done = done + 1
              plugin_log.update_progress(done, total)
              plugin_log.log("Successfully updated: " .. name)
            else
              plugin_log.log("Failed to update: " .. name)
            end
          end)
        end)
      else
        plugin_log.log("Skipping " .. name .. ": Not a Git repository")
      end
    end
  end
end


vim.api.nvim_create_user_command('PluginInstall', function()
  set_total_plugins()
  done = 0
  for k, v in pairs(plugins_list) do
    install_plugin(v, k)
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
