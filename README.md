Dotfiles
========

This is my collection of [configuration files](http://dotfiles.github.io/).

Usage
-----

Pull the repository, and then create the symbolic links [using GNU
stow](https://www.gnu.org/software/stow/).

```bash
$ git clone git@github.com:jg-rc/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish neovim tmux # plus whatever else you'd like
$ stow * # if you want them all :O 
```

License
-------

[MIT](http://opensource.org/licenses/MIT).
