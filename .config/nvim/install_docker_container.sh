# Install dependecies (icu-devtools is needed for MPLS)
apt update && apt install -y wget curl git icu-devtools silversearcher-ag

# Import Existing vim Configuration
mkdir -p ~/.config/nvim
mkdir -p ~/.config/coc/ultisnips
ln -s ~/.nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/.nvim/coc/ultisnips/python.snippets ~/.config/coc/ultisnips/python.snippets

# Download and install the appimage, use the output-document option to rename it to nvim
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document ~/.config/nvim/nvim.appimage

# Set the owner to root, and make nvim accessible to all users
chmod +x ~/.config/nvim/nvim.appimage

# Extract nvim appimage
cd ~/.config/nvim
~/.config/nvim/nvim.appimage --appimage-extract

# Create a symbolic link to nvim binary
ln -s ~/.config/nvim/squashfs-root/usr/bin/nvim /usr/local/bin/nvim

# Install the Vim-plug Plugin Manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the NeoVim Python module
pip3 install neovim pynvim

# Install nodejs when necessary (for coc.nvim plugin)
curl -sL install-node.now.sh/lts | bash -s -- --yes
