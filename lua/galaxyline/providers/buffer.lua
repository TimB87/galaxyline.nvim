local buffer = {}

local buf_icon = {
  help = '  ',
  defx = '  ',
  nerdtree = '  ',
  denite = ' 󰈞 ',
  ['vim-plug'] = '  ',
  vista = ' 󰓽',
  vista_kind = '  ',
  dbui = '  ',
  NeogitStatus = '  ',
  NvimTree = '  ',
  netrw = '  ',
}

buffer.get_buffer_type_icon = function()
  return buf_icon[vim.bo.filetype]
end

buffer.get_buffer_filetype = function()
  return vim.bo.filetype:upper()
end

-- get buffer number
buffer.get_buffer_number = function()
  return vim.api.nvim_win_get_buf(0)
end

return buffer
