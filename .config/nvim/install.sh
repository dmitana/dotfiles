# Install dependecies
yay -S --noconfirm wget curl git ripgrep g++

# Install neovim
yay -S --noconfirm neovim

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
#
# Python (pyright + pylsp)
sudo npm i -g pyright
pip3 install --user -r ~/.config/nvim/requirements-dev.txt

# Go (gopls)
GO111MODULE=on go get golang.org/x/tools/gopls@latest

# Eslint (JS, JS), JSON, HTML and CSS (SCSS, LESS)
sudo npm i -g vscode-langservers-extracted

# Typescript and Javascript
sudo npm i -g typescript typescript-language-server
