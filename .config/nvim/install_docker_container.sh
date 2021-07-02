# Install dependecies
apt update && apt install -y software-properties-common wget curl git g++

# Intall ripgrep
add-apt-repository -y ppa:x4121/ripgrep
apt update && apt install -y ripgrep

# Import Existing vim Configuration
mkdir -p ~/.config/nvim
ln -s ~/.nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/.nvim/lua ~/.config/nvim/lua
ln -s ~/.nvim/ftdetect ~/.config/nvim/ftdetect
ln -s ~/.nvim/ftplugin ~/.config/nvim/ftplugin

# Download and install the appimage, use the output-document option to rename it to nvim
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document ~/.config/nvim/nvim.appimage

# Set the owner to root, and make nvim accessible to all users
chmod +x ~/.config/nvim/nvim.appimage

# Extract nvim appimage
cd ~/.config/nvim
~/.config/nvim/nvim.appimage --appimage-extract

# Create a symbolic link to nvim binary
ln -s ~/.config/nvim/squashfs-root/usr/bin/nvim /usr/local/bin/nvim

# Install the Packer plugin manager
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install python3 if it doesn't exist
if ! command -v python3 &> /dev/null
then
    apt install -y python3 python3-distutils
fi

# Install pip3 if it doesn't exist
if ! command -v pip3 &> /dev/null
then
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
fi

# Upgrade pip
pip3 install pip --upgrade

# Install the NeoVim Python module
pip3 install neovim pynvim

# Install nodejs if doesn't exist
if ! command -v node &> /dev/null
then
    curl -sL install-node.now.sh/lts | bash -s -- --yes
fi

# LSP installation
# Python (pyright + pylsp)
npm i -g pyright
pip3 install -r ~/.nvim/requirements-pylsp.txt

# Go (gopls)
GO111MODULE=on go get golang.org/x/tools/gopls@latest
