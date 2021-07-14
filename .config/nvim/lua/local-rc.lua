-- Source: https://github.com/neovim/neovim/issues/13501#issuecomment-758604989
local local_vimrc = vim.fn.getcwd()..'/.nvimrc.lua'
if vim.loop.fs_stat(local_vimrc) then
  dofile(local_vimrc)
  print(local_vimrc .. ' loaded.')
else
  print(local_vimrc .. ' exists but is not loaded.')
end
