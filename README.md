# termight.nvim

Termight is a neovim extension designed to make handling terminal buffers in neovim easier. It makes it easy to switch between terminal buffers, and to create new ones. **Please note this is a work in progress, and that there are, and will be bugs.**

## Installation
Though only tested with [vim-plug](https://github.com/junegunn/vim-plug), you should be able to install termight with any nvim plugin manager.
#### Vim-plug:
````vim
Plug 'anott03/termight.nvim', { 'branch': 'main' }
````
## Usage
Termight adds the `OpenTerm` editor command. You can then make the call `OpenTerm x` where `x` is either 1, 2, 3 or 4. I recommend creating keybindings for this. I have the following in my `init.vim`:
````vim
nnoremap <leader>1 :OpenTerm 1
nnoremap <leader>2 :OpenTerm 2
nnoremap <leader>3 :OpenTerm 3
nnoremap <leader>4 :OpenTerm 4
````
