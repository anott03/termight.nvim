# termight.nvim
Termight is a neovim extension designed to make handling terminal buffers in neovim easier. It makes it easy to switch between terminal buffers, and to create new ones. **Please note this is a work in progress, and that there are, and will be bugs.**
## Installation
Though only tested with [vim-plug](https://github.com/junegunn/vim-plug), you should be able to install termight with any nvim plugin manager.
#### Vim-plug:
To install the latest stable release:
````vim
Plug 'anott03/termight.nvim', { 'branch': 'v1' }
````
To install the latest version, actively being developed upon:
````vim
Plug 'anott03/termight.nvim', { 'branch': 'main' }
````
## Why Use Termight?
I often use terminal buffers to run or compile my code, but when I would go back to my code and later open a terminal again (using the `:term` editor command), I would lose all the output I had previously. Termight allows you to easily access the same buffer you had open before, so as long as you do not destroy the buffer (NOTE: `:q` destroys the buffer), you can always make a call to `OpenTerm` and be placed back into the same buffer, with all of your previous output.
## Usage
Termight adds the `OpenTerm` editor command. You can then make the call `OpenTerm x` where `x` is either 1, 2, 3 or 4. I recommend creating keybindings for this:
````vim
nnoremap <leader>1 :OpenTerm 1
nnoremap <leader>2 :OpenTerm 2
nnoremap <leader>3 :OpenTerm 3
nnoremap <leader>4 :OpenTerm 4
````
Or, if you're using `init.lua`:
````lua
vim.api.nvim_set_keymap("n", "<leader>1", "<CMD>OpenTerm 1<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>2", "<CMD>OpenTerm 2<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>3", "<CMD>OpenTerm 3<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>4", "<CMD>OpenTerm 4<CR>", {})
````
