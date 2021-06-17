## build neovim from source :O :O

### install build dependencies

https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites

```sh
brew install ninja libtool automake cmake pkg-config gettext
```

### clone the repository

```sh
git clone https://github.com/neovim/neovim.git
```

```sh
cd neovim
```
if previously you built the execute 

```sh
make distclean
```

then build it into the OSX bins folder this builds the release version if you built previously remove`build`folder with


```sh
rm -rf build
```

then run

```sh
$ make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local install
```

## useful links

[neovim plugins](https://stsewd.dev/es/posts/neovim-plugins)
[neovim instalation and configuration](https://stsewd.dev/es/posts/neovim-installation-configuration)

