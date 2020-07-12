# Install dependecies (icu is needed for MPLS)
yay -S --noconfirm wget curl git icu the_silver_searcher

# Import Existing vim Configuration
# mkdir -p ~/.config/nvim
# mkdir -p ~/.config/coc/ultisnips
# ln -s ~/.nvim/init.vim ~/.config/nvim/init.vim
# ln -s ~/.nvim/coc-settings.json ~/.config/nvim/coc-settings.json
# ln -s ~/.nvim/coc/ultisnips/python.snippets ~/.config/coc/ultisnips/python.snippets

# Download and install the appimage, use the output-document option to rename it to nvim
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim

# Set the owner to root, and make nvim accessible to all users
chmod +x nvim
sudo chown root:root nvim

# Move the binary file to /usr/local/bin
sudo mv nvim /usr/local/bin

# Install the Vim-plug Plugin Manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install python3 if doesn't exist
if ! command -v python3 &> /dev/null
then
    yay -S --noconfirm python3 python3-distutils
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
