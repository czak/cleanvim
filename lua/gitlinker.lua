local M = {}

local function build_anchor()
  if not vim.fn.mode():match("[vV]") then
    return ""
  end

  -- getpos returns a list of [bufnum, lnum, col, off]
  local l1 = vim.fn.getpos(".")[2] -- current cursor position
  local l2 = vim.fn.getpos("v")[2] -- opposite side of visual selection

  if l1 == 0 or l2 == 0 then
    return ""
  end

  if l1 > l2 then
    l1, l2 = l2, l1
  end

  if l1 == l2 then
    return ("#L%d"):format(l1)
  end
  return ("#L%d-L%d"):format(l1, l2)
end

local function get_url_impl()
  local remote_line = vim.fn.systemlist('git remote -v')[1]
  if not remote_line then return nil, "No git remote found" end
  local remote_url = vim.split(remote_line, '%s+')[2]

  local base_url = remote_url
      :gsub('%.git$', '')
      :gsub('git@github.com:', 'https://github.com/')

  local commit_hash = vim.trim(vim.fn.system('git rev-parse HEAD'))
  local repo_root = vim.trim(vim.fn.system('git rev-parse --show-toplevel'))
  local file_path = vim.fn.expand('%:p')
  local relative_path = file_path:sub(#repo_root + 2)
  local anchor = build_anchor()

  return string.format('%s/blob/%s/%s%s', base_url, commit_hash, relative_path, anchor)
end

function M.get_url()
  local ok, result = pcall(get_url_impl)
  if not ok then
    vim.notify(result or "Failed to generate Git URL", vim.log.levels.WARN)
    return nil
  end
  return result
end

function M.open()
  local url = M.get_url()
  if url then
    vim.ui.open(url)
    vim.notify("Opening URL...")
  end
end

function M.yank()
  local url = M.get_url()
  if url then
    vim.fn.setreg('+', url)
    vim.notify("Copied URL to clipboard")
  end
end

return M
