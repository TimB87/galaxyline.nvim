local enabled = false
local cache = ''
local options = {
  c_langs = { 'arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php' },
  max_lines = 5000,
}

local function search(prefix, pattern)
  local line = vim.fn.search(pattern, 'nw')
  if line == 0 then
    return ''
  end
  return string.format('[%s:%d]', prefix, line)
end

local function check_trailing()
  return search('trailing', [[\s$]])
end

local function check_mix_indent()
  local tst = [[(^\t* +\t\s*\S)]]
  local tls = string.format([[(^\t+ {%d,}\S)]], vim.bo.tabstop)
  local pattern = string.format([[\v%s|%s]], tst, tls)
  return search('mix-indent', pattern)
end

local function check_mix_indent_file()
  local head_spc = [[\v(^ +)]]
  if vim.tbl_contains(options.c_langs, vim.bo.filetype) then
    head_spc = [[\v(^ +\*@!)]]
  end
  local indent_tabs = vim.fn.search([[\v(^\t+)]], 'nw')
  local indent_spc = vim.fn.search(head_spc, 'nw')
  if indent_tabs == 0 or indent_spc == 0 then
    return ''
  end
  return string.format('[mix-indent-file:%d,%d]', indent_spc, indent_tabs)
end

local function check_conflict()
  local annotation = [[\%([0-9A-Za-z_.:]\+\)\?]]
  local raw_pattern = [[^\%%(\%%(<\{7} %s\)\|\%%(=\{7\}\)\|\%%(>\{7\} %s\)\)$]]
  if vim.bo.filetype == 'rst' then
    raw_pattern = [[^\%%(\%%(<\{7} %s\)\|\%%(>\{7\} %s\)\)$]]
  end
  local pattern = string.format(raw_pattern, annotation, annotation)
  return search('conflict', pattern)
end

local function set_cache_autocmds(augroup)
  vim.cmd(string.format('augroup %s', augroup))
  vim.cmd 'autocmd!'
  vim.cmd(
    string.format('autocmd CursorHold,BufWritePost * unlet! b:%s', augroup)
  )
  vim.cmd 'augroup END'
end
local function get_item()
  if not enabled then
    set_cache_autocmds 'galaxyline_whitespace'
    enabled = true
  end
  if vim.bo.readonly or not vim.bo.modifiable then
    return ''
  end
  if vim.fn.line '$' > options.max_lines then
    return ''
  end
  if vim.b.galaxyline_whitespace then
    return cache
  end
  vim.b.galaxyline_whitespace = true
  cache = table.concat {
    check_trailing(),
    check_mix_indent(),
    check_mix_indent_file(),
    check_conflict(),
  }
  return cache
end

return {
  get_item = get_item,
}
