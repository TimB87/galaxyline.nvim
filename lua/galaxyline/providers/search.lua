local search = {}

search.get_results = function()
  local search_term = vim.fn.getreg '/'
  local search_count = vim.fn.searchcount {
    recompute = 1,
    maxcount = -1,
  }

  local active_result = vim.v.hlsearch == 1 and search_count.total > 0
  if active_result then
    return string.format(
      '/%s [%d/%d]',
      search_term,
      search_count.current,
      search_count.total
    )
  end
end

return search
