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

  -- getting the current window width and height
  -- as well as defining the factor size the floating
  -- window on
  local stats = vim.api.nvim_list_uis()[1]
  local width = stats.width;
  local height = stats.height;
  local factor = 0.9;

  -- creating a new buffer
  local bufh = vim.api.nvim_create_buf(false, true)
  -- creating the window
  vim.api.nvim_open_win(bufh, true, {
    relative = "editor",
    width    = math.floor(width * factor),
    height   = math.floor(height * factor),
    col      = math.floor(width * (1 - factor) / 2),
    row      = math.floor(height * (1 - factor) / 2)
  })
  vim.api.nvim_exec("set nonu norelativenumber signcolumn=no colorcolumn=", nil)

  vim.cmd(":term")
  -- definitions of some key sequences
  local carriage_return = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  local exit_term = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)

  -- a super hacky way to remove the prompt from the window
  vim.api.nvim_feedkeys("aexport PS1='' && clear", "n", {})
  vim.api.nvim_feedkeys(carriage_return, "n", {})
  vim.api.nvim_feedkeys(exit_term, "n", {})

  -- insert the command into the terminal
  vim.api.nvim_feedkeys("a" .. cmd, "n", {})
  vim.api.nvim_feedkeys(carriage_return, "n", {})

  -- exit insert mode
  vim.api.nvim_feedkeys(exit_term, "n", {})

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
