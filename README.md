# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).

## Usage

Pull the repository, and then create the symbolic links [using GNU
stow](https://www.gnu.org/software/stow/).

```bash
$ git clone git@github.com:jg-rc/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish neovim tmux # plus whatever else you'd like
$ stow * # if you want them all :O
```
## terminal emulators
i use kitty term as my primary terminal emulator
```sh
brew cask install kitty
```
## file explorer 
ranger is the file explorer that i used, is a vim based file explorer very flexible
```sh
brew install ranger
```
```sh
pip install ranger-fm
```
ranger allow to preview image inside the console with the help of pillow python3 library
```sh
pip install pillow 
```
## (zsh) fuzzy files finder
i use fzf for fuzzy find files, command history and more

```sh
brew install fzf
```

## ag the silver searcher
ag is a tool similar to grep that let you find files recursively and find strings inside files some libraries in my dotfiles are configure to use it 
by default (denite vim plugin, fzf)

```sh
brew install the_silver_searcher
```
## terminal multiplexor (tmux)
i use tmux as a way to show multiple terminals in panels and tabs

```sh
brew install tmux
```

## Tmux Plugin Manager

```bash
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## comunity driven zsh configuration (oh my zsh) 
i use oh my zsh as a zsh config is a bit bloated i know but it's a quick start, i'm planning to create my own `zshrc` with only the minimal
```sh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### some zsh plugins

zsh is a wonderfull shell because of the broad number of plugins the comunity has built

* zsh syntax highlighting - prompt highlighting for existing commands and directories

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

* zsh autosuggestions - fish like inline autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

```

## zsh prompt (Spaceship) 

i use Spaceship zsh as the prompt it show vital information like node/ruby/npm version, sometimes is a bit slow but it works

*this installation is for oh my zsh users*
Clone this repo:

```zsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
```

Symlink `spaceship.zsh-theme` to your oh-my-zsh custom themes directory:

```zsh
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Set `ZSH_THEME="spaceship"` in your `.zshrc`.


ship Confirmation template not found
payment Confirmation declined not found in PPT

### Ruby version manager

```sh
\curl -sSL https://get.rvm.io | bash -s stable
```

```sh
$ rvm install 2.6.3
```

## thyme pomodoro timer

```sh
$ gem install thyme
```

get notifications everytime the timer is up with terminal-notifier

```sh
$ gem install terminal-notifier
```

## shopify commands on the terminal

```sh
$ brew install shpotify
```

## (vtop monitor)

```
npm install -g vtop
```

## License

[MIT](http://opensource.org/licenses/MIT).

```sh
brew install mplayer
brew install thefuck
brew install tree
brew install cmus #musix
brew install moc #music
brew install newsboat #rss reader
brew install calcurse #calendar
pip3 install howdoi # search in stack overflow
gem install soundcloud2000 #soundcloud client
pip3 install gcalcli # google calendar
brew install googler # google from here
brew install ranger #file browser
brew install rtv # reddit
brew install weechat  #slack and irc usa wee-slack https://github.com/wee-slack/wee-slack
lsappinfo info -only bundleid kitty retorna bundle id  para usar con notification_Center

brew install neomutt  #mail https://webgefrickel.de/blog/a-modern-mutt-setup
```
