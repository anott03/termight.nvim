local vim = vim
local bufs = vim.g["term_buf_list"]

local function initializeNewTerm()
    local idx = vim.g["idx"]
    -- creates a new buffer and adds it to the list
    vim.cmd("let g:term_buf_list[g:idx - 1] = "
      .. vim.api.nvim_create_buf(true, false))
    bufs = vim.g["term_buf_list"] -- reload buf list
    -- open the buf and run a terminal in it
    vim.api.nvim_set_current_buf(bufs[idx])
    vim.api.nvim_exec(":term", {})
end

-- checks if the buffer handle is in the list of active bufers
local function bufExists(idx)
  for i=1, #vim.api.nvim_list_bufs() do
    if bufs[idx] == vim.api.nvim_list_bufs()[i] then
        return true
      end end
    return false
end

local function openTerm()
  local idx = vim.g["idx"]
  if idx and idx <= #bufs then
    -- create a new term if there isn't an active on at idx
    if bufs[idx] == 0 or not bufExists(idx) then
      initializeNewTerm()
    else vim.api.nvim_exec(bufs[idx] .. "buf!", nil) end
  else
    print("invalid index")
  end
end

-- run a shell command and view the output in a floating window
local function runShellCommand()
  local cmd = vim.g["termight_cmd"]

  local info = require('plenary.window.float').percentage_range_window(0.9, 0.9, {})
  local bufh = info.bufnr
  vim.fn.termopen(cmd)

  -- bindings: esc to close the window, disable ways to enter insert mode
  vim.api.nvim_buf_set_keymap(bufh, "n", "<ESC>",
    "<CMD>lua vim.api.nvim_buf_delete("..bufh..", {force=true})<CR>", {})
  vim.api.nvim_buf_set_keymap(bufh, "n", "i", "<nop>", {})
  vim.api.nvim_buf_set_keymap(bufh, "n", "I", "<nop>", {})
  vim.api.nvim_buf_set_keymap(bufh, "n", "a", "<nop>", {})
  vim.api.nvim_buf_set_keymap(bufh, "n", "A", "<nop>", {})
end

return {
  openTerm = openTerm,
  runShellCommand = runShellCommand
}
