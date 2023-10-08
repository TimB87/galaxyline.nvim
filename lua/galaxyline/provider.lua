local function load_providers()
  local vcs = require 'galaxyline.providers.vcs'
  local fileinfo = require 'galaxyline.providers.fileinfo'
  local buffer = require 'galaxyline.providers.buffer'
  local search = require 'galaxyline.providers.search'
  local extension = require 'galaxyline.providers.extensions'
  local whitespace = require 'galaxyline.providers.whitespace'
  local lspclient = require 'galaxyline.providers.lsp'

  local galaxyline_providers = {
    BufferIcon = buffer.get_buffer_type_icon,
    BufferNumber = buffer.get_buffer_number,
    FileTypeName = buffer.get_buffer_filetype,
    GitBranch = vcs.get_git_branch,
    DiffAdd = vcs.diff_add,
    DiffModified = vcs.diff_modified,
    DiffRemove = vcs.diff_remove,
    LineColumn = fileinfo.line_column,
    FileFormat = fileinfo.get_file_format,
    FileEncode = fileinfo.get_file_encode,
    FileSize = fileinfo.get_file_size,
    FileIcon = fileinfo.get_file_icon,
    FileName = fileinfo.get_current_file_name,
    FilePath = fileinfo.get_current_file_path,
    SFileName = fileinfo.filename_in_special_buffer,
    LinePercent = fileinfo.current_line_percent,
    ScrollBar = extension.scrollbar_instance,
    VistaPlugin = extension.vista_nearest,
    WhiteSpace = whitespace.get_item,
    GetLspClient = lspclient.get_lsp_client,
    SearchResults = search.get_search_results,
    LazyUpdates = extension.lazyupdates,
  }

  local diagnostic = require 'galaxyline.providers.diagnostic'
  galaxyline_providers.DiagnosticError = diagnostic.get_diagnostic_error
  galaxyline_providers.DiagnosticWarn = diagnostic.get_diagnostic_warn
  galaxyline_providers.DiagnosticHint = diagnostic.get_diagnostic_hint
  galaxyline_providers.DiagnosticInfo = diagnostic.get_diagnostic_info

  return galaxyline_providers
end

return {
  load_providers = load_providers,
}
