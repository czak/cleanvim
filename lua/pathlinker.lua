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
    return (":%d"):format(l1)
  end
  return (":%d-%d"):format(l1, l2)
end

function M.yank()
  local path = vim.fn.expand('%') .. build_anchor()
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end

return M
