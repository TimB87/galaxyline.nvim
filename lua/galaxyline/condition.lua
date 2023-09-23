local condition = {}

condition.buffer_not_empty = function()
  local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, vim.fn.line '$', true)
  if buffer_lines[1] == '' and #buffer_lines == 1 then
    return false
  end
  return true
end

condition.check_git_workspace = function()
  local get_git_dir = require('galaxyline.providers.vcs').get_git_dir
  if vim.bo.buftype == 'terminal' then
    return false
  end
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  -- if file is a symlinks
  if vim.fn.getftype(current_file) == 'link' then
    local real_file = vim.fn.resolve(current_file)
    current_dir = vim.fn.fnamemodify(real_file, ':h')
  else
    current_dir = vim.fn.expand '%:p:h'
  end
  local result = get_git_dir(current_dir)
  if not result then
    return false
  end
  return true
end

condition.hide_in_width = function()
  local squeeze_width = vim.api.nvim_win_get_width(0) / 2
  if squeeze_width >= 50 then
    return true
  end
  return false
end

condition.check_active_lsp = function()
  local clients = vim.lsp.buf_get_clients()
  return next(clients) ~= nil
end

return condition
