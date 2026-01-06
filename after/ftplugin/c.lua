if vim.fn.has("win32") == 1 then
  vim.bo.makeprg = "build.bat debug"
else 
  vim.bo.makeprg = "build.sh debug"
end
