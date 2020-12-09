# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).
**Feel free to create Issues to this repo if something in this config is not working as expected**

i'm a huge fan of command line tools, this repository is my personal store of configurations for tools
that i use or have used in the past. below is the list of tools that i use on a daily basis

- Text Editor [Neovim](https://neovim.io/)
- Terminal Emulator [Kitty](https://sw.kovidgoyal.net/kitty/)
- Terminal multiplexor [Tmux](https://github.com/tmux/tmux/wiki)
- To Load Tmux layouts from a file i use [Tmuxinator](https://github.com/tmuxinator/tmuxinator)
- Shell [Zsh](https://es.wikipedia.org/wiki/Zsh)
- File manager [ranger](https://github.com/ranger/ranger)

*Every folder in this repository store the relevan configurations for the tools i mentioned,
there may be more folders that names in the list above, this is due some tools i have tried in the past
but i not longer use.*

## Dotfiles Setup

for the dotfiles setup i rely on the [ GNU tool stow](https://www.gnu.org/software/stow/), this way you can pick and choose the configurations files
you will be using, you can get `stow` by running the following command

```bash 
$ brew install stow
```

Now you can pull this repository into your home `~` directory, then create the symbolic links using `stow`  the commands below will do the tricky.

```bash
$ git clone git@github.com:jg-rc/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow nvim # for neovim only 
$ stow tmux nvim # for neovim and tmux 
$ stow kitty  # for kitty config only
$ stow kitty nvim zsh # pick and choose as many configs as you want
```
## Tools Instalation, Requirements and whats included

***i use brew as the package manager in the instalation instructions because my main OS is OSX if your main OS is different please 
research for a package manager that let you get these tools, don't worry the dotfiles will continue to work no matter how you get the tools***

### Text editor (neovim)
![](https://raw.githubusercontent.com/juangabrielr4/dotfiles/master/nvim/.config/nvim/neovim.png)
Neovim is a fork of vim, is a comunity driven effort to bring a more colaborative project than vim.
At it's core is basically vim, but it includes more features and improvements.

i personally like to use the `head` version because i feel is very stable and i can have early access
to new features. sometimes i'm in the mood of building from source, then i follow  [Building from source](https://github.com/juangabrielr4/dotfiles/blob/master/nvim/.config/nvim/build-from-source.md)

```sh
brew install neovim --HEAD
```
#### Requirements
 
in order to get neovim working properly using my configuration files you will need to get python support, some 
of the plugins that i use are written in python. to achieve that you must install "pynvim" module with pip

```sh
pip3 install --user pynvim
```
if you don't have pip installed in your system please run.

```sh
sudo easy_install pip
```

For recursive search of code i rely on a Code Searching tool called
[Ag the silver searcher](https://github.com/ggreer/the_silver_searcher) 
you can install it with the command below

```sh
brew install the_silver_searcher 
```
**Once you open Neovim for the first time you will get some errors that's normal, this is because plugins are on installed yet.**
So please ignore errors and execute `:PlugInstall` if everything is ok you will see a list of plugins installing.

you can checkout `:checkhealth` for more info ;)

to see what's included in my neovim configuration (custom mappings,themes & more) visit the [README](https://github.com/juangabrielr4/dotfiles/blob/master/nvim/.config/nvim/README.md)


### Terminal multiplexor (tmux)

![](https://raw.githubusercontent.com/juangabrielr4/dotfiles/master/tmux/tmux.png)
i use tmux as a way to show multiple terminals in panels and tabs

```sh
brew install tmux
```

### Terminal emulator (kitty)

![](https://raw.githubusercontent.com/juangabrielr4/dotfiles/master/kitty/.config/kitty.png)
i use kitty term as my primary terminal emulator

```sh
brew cask install kitty
```

### Shell ( Zsh )
![](https://raw.githubusercontent.com/juangabrielr4/dotfiles/master/zsh/zsh.png)

Since MacOSX version 10.15 (catalina) zsh is included as the default shell, so not need for any kind of installation if you
are a Mac user
my `zsh` configuration is very lightweight, i have used bloated configs like `oh my zsh` in the past and felt the pain of a
slow shell, that's why i made my own using only a couple of zsh plugins listed below 

#### some zsh plugins

zsh is a wonderfull shell because of the broad number of plugins the comunity has built

- zsh syntax highlighting - prompt highlighting for existing commands and directories

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- zsh autosuggestions - fish like inline autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

```
### File explorer (ranger)

![](https://raw.githubusercontent.com/juangabrielr4/dotfiles/master/ranger/ranger.png)
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


### node version manager

```sh
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
```

```sh
$ nvm install stable
```

```sh
$ nvm use stable
```

### Ruby version manager

```sh
$ curl -sSL https://get.rvm.io | bash -s stable
```

```sh
$ rvm install 2.6.3
```

### python version manager

```sh
$ brew install pyenv
```

```sh
$ pyenv install 3.8.8
```

```sh
$ pyenv global 3.8.8
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
