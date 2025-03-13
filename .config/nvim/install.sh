# Install dependecies
yay -S --noconfirm wget curl git ripgrep g++

# Install neovim
yay -S --noconfirm neovim

# Install the Packer plugin manager
yay -S --noconfirm packer

# Install python3 if it doesn't exist
if ! command -v python3 &> /dev/null
then
    yay -S --noconfirm python3 python-setuptools
fi

# Install pip3 if it doesn't exist
if ! command -v pip3 &> /dev/null
then
    yay -S --noconfirm python-pip
fi

# Install the NeoVim Python module
yay -S python-pynvim

# Install nodejs if doesn't exist
if ! command -v node &> /dev/null
then
    yay -S --noconfirm nodejs-lts-iron npm
fi

# LSP installation
#
# Python (pyright + pylsp)
sudo npm i -g pyright
yay -S $(cat ~/.config/nvim/requirements-dev-yay.txt)

# Go (gopls)
go install golang.org/x/tools/gopls@latest

# Eslint (JS, JS), JSON, HTML and CSS (SCSS, LESS)
sudo npm i -g vscode-langservers-extracted

# Typescript and Javascript
sudo npm i -g typescript typescript-language-server
