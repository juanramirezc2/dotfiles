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

## allow terminal to access the clipboard

```sh
$brew install pbcopy
```

## install download fira code retina patched witn nerd fonts

```sh
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts && cd nerd-fonts && ./install.sh FiraCode
```

## oh my zsh

```sh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### some zsh plugins

zsh syntax highlighting

```sh
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

```

zsh autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

```

## ag the silver searcher

denite uses the silver searcher for searching into the source code

```sh
$brew install the_silver_searcher
```

## tmux

```sh
brew install tmux
```

## universal ctags needed by gutentags

install ctags and use it as default local bin OSX has its own ctags package and sucks
brew install ctags
Afterwards, you may need to set the alias to the new version by running:

```sh
alias ctags="`brew --prefix`/bin/ctags"
alias ctags >> ~/.zshrc
```

clone this .ctags file under `~/.ctags`

```sh
git clone https://github.com/romainl/ctags-patterns-for-javascript
```

echo "set tags=tags" >> ~/.vimrc
ignore tags in local git repository using

```sh
$ echo "tags" >> .git/info/exclude
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

ship Confirmation template not found
payment Confirmation declined not found in PPT
