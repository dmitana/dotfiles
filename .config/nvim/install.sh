# Install dependecies
yay -S --noconfirm wget curl git ripgrep g++

# Download and install the appimage, use the output-document option to rename it to nvim
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim

# Set the owner to root, and make nvim accessible to all users
chmod +x nvim
sudo chown root:root nvim

# Move the binary file to /usr/local/bin
sudo mv nvim /usr/local/bin

# Install the Packer plugin manager
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install python3 if it doesn't exist
if ! command -v python3 &> /dev/null
then
    yay -S --noconfirm python3 python3-distutils
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
pip3 install --user neovim pynvim

# Install nodejs if doesn't exist
if ! command -v node &> /dev/null
then
    yay -S --noconfirm nodejs-lts-erbium npm
fi

# LSP installation
# Python (pyright + pylsp)
sudo npm i -g pyright
pip3 install --user -r ~/.config/nvim/requirements-pylsp.txt

# Go (gopls)
GO111MODULE=on go get golang.org/x/tools/gopls@latest
