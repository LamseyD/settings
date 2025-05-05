Install oh-my-zsh
Install zsh-syntax-highlighting via brew brew install zsh-syntax-highlighting

Install zsh-autosuggestions
Install enhancd
Install powerlevel10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


Copy the zshrc and the vimrc into `.zshrc` and `.vimrc`

Restart your terminal and go through the powerlevel10k setups

For vim, you'll need to install onedark.vim and follow the instructions, you may need to create `.vim` and `.vim/autoload` and `.vim/plugged`, and `.vim/colors` folders
