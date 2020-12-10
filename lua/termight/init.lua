local vim = vim
local bufs = vim.g["term_buf_list"]

local function initializeNewTerm()
    local idx = vim.g["idx"]
    vim.cmd("let g:term_buf_list[g:idx - 1] = "  .. vim.api.nvim_create_buf(true, false))
    bufs = vim.g["term_buf_list"]
    vim.api.nvim_exec(bufs[idx] .. "buf! | term", nil)
end

local function bufExists(idx)
    for i=1, #vim.api.nvim_list_bufs() do
      if bufs[idx] == vim.api.nvim_list_bufs()[i] then
        return true
      end
    end
    return false
end

local function openTerm()
  local idx = vim.g["idx"]
  if idx and idx <= #bufs then
    if bufs[idx] == 0 then
      initializeNewTerm()
    else
      if bufExists(idx) then vim.api.nvim_exec(bufs[idx] .. "buf!", nil)
      else initializeNewTerm() end
    end
  else
    print("invalid index")
  end
end

local function createTerm()
  local bufh = vim.api.nvim_create_buf(true, false)
  table.insert(bufs, bufh);
  vim.api.nvim_exec("sp | " .. bufh .. "buf! | term", nil)
end

local function closeTerm()
  -- local cbuf = vim.api.nvim_get_current_buf()

  if string.find(vim.api.nvim_buf_get_name({}), "term:/", 1, true) then
    vim.api.nvim_exec(":bp", nil)
  end
end

return {
  createTermBuffer = createTerm,
  openTerm = openTerm,
  closeTerm = closeTerm,
}
