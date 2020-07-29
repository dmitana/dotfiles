# Install dependecies (icu-devtools is needed for MPLS)
apt update && apt install -y wget curl git icu-devtools silversearcher-ag

# Import Existing vim Configuration
mkdir -p ~/.config/nvim
mkdir -p ~/.config/coc/ultisnips
ln -s ~/.nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.nvim/ftdetect ~/.config/nvim/ftdetect
ln -s ~/.nvim/ftplugin ~/.config/nvim/ftplugin
ln -s ~/.nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/.coc/ultisnips/python.snippets ~/.config/coc/ultisnips/python.snippets

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

# Install python3 if doesn't exist
if ! command -v python3 &> /dev/null
then
    apt install -y python3 python3-distutils
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
fi

# Upgrade pip
pip3 install pip --upgrade

# Install the NeoVim Python module
pip3 install neovim pynvim

# Install Flake8 extensions
pip3 install -r ~/.nvim/flake8_extensions.txt

# Install nodejs if doesn't exist
if ! command -v node &> /dev/null
then
    curl -sL install-node.now.sh/lts | bash -s -- --yes
fi
