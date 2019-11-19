## honer
```sh
https://github.com/puffnfresh/Honer.app
```
## tmux 
```sh
brew install tmux
```
## install download fira code retina patched witn nerd fonts
```sh
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts && cd nerd-fonts && ./install.sh FiraCode
```

`Preferences->Profiles->text`
in the non-ACCII font select hack nerd font
TODO: patch comic code using [fontforge](https://github.com/ryanoasis/nerd-fonts#option-8-patch-your-own-font)
## comic code font with ligatures

in

```sh
fonts/comic code with ligatures
```

install all the fonts and go to the iterm

in iTerm go to

`Preferences->Profiles->text`
in Font select `Fira Code Regular`
set Font size to `14`
check set ligatures `on`
an image tell more than a thousand worlds
![iterm text settings](https://i.paste.pics/ea6ce83237ec37dc2067e52a11c5579a.png)

## Iterm 2 one dark color scheme

### Installation Instructions

- Clone or download this repo

```sh
 git clone git@github.com:nathanbuchar/atom-one-dark-terminal.git && cd atom-one-dark-terminal
```

- Go to `schemes/` folder

- Double click on selected `*.itermcolors` file. It will open a new Terminal window with that
  color scheme.

- Set the scheme as the default one with `Preferences -> Profiles -> Colors -> Load Presets`

# requirements

## useful links

[neovim plugins](https://stsewd.dev/es/posts/neovim-plugins)
[neovim instalation and configuration](https://stsewd.dev/es/posts/neovim-installation-configuration)

## allow terminal to access the clipboard

```sh
$brew install pbcopy
```

## coc vim

````sh
:CocInstall coc-json coc-css coc-tsserver coc-snippets coc-eslint coc-prettier 
```

## compile YCM using typescript engine

run

```sh
$ youcompleteme/install.py --ts-completer

````

create a ~/.jsconfig.json file with

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "ES6",
    "allowJs": true,
    "checkJs": true,
    "jsx": "react",
    "outDir": "./build",
    "removeComments": true,
    "noEmit": true,
    "pretty": true,
    "skipLibCheck": true,
    "strict": true,
    "moduleResolution": "node",
    "esModuleInterop": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/node_modules/*"]
}
```

[more info about TS semantic autocompletion](https://github.com/ycm-core/YouCompleteMe#javascript-and-typescript-semantic-completion)

## ag the silver searcher

ackvim support ag the silver searcher as a command so we need to install it

```sh
$brew install the_silver_searcher
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

then build it into the OSX bins folder this builds the release version if you built previously remove`build`folder with

```sh
rm -rf build
```

then run

```sh
$make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local install
```

run`:checkhealth` for more info ;)

# nodejs neovim plugins support ;)

`$ npm install -g neovim`

# vim custom text objects

## entire buffer objects [more info](https://github.com/kana/vim-textobj-entire/blob/master/README.md)

- `ae` targets the entire content of the current buffer.
- `ie` is similar to `ae`, but `ie` does not include leading and trailing empty
  lines. `ie` is handy for some situations. For example,
  1. Paste some text into a new buffer (`<C-w>n"*P`)
     -- note that the initial empty line is left as the last line.
  2. Edit the text (`:%s/foo/bar/g` etc)
  3. Then copy the resulting text to another application (`"*yie`)

## indent custom objects [more info](https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt)

| Key bindings | Description                                                 |
| ------------ | ----------------------------------------------------------- |
| `<count>ai`  | **A**n **I**ndentation level and line above.                |
| `<count>ii`  | **I**nner **I**ndentation level (**no line above**).        |
| `<count>aI`  | **A**n **I**ndentation level and lines above/below.         |
| `<count>iI`  | **I**nner **I**ndentation level (**no lines above/below**). |

## line custom objects [more info](https://github.com/michaeljsmith/vim-indent-object/blob/master/README.md)

### Modes {lhs} {rhs}

vo al |<Plug>(textobj-line-a)|
vo il |<Plug>(textobj-line-i)|

## matching pairs custom objects [more info](https://github.com/andymass/vim-matchup/blob/master/README.md)

### (b.1) full set of text objects

- `i%` the inside of an any block
- `1i%` the inside of an open-to-close block
- `{count}i%` If count is greater than 1, the inside of the `{count}`th
  surrounding open-to-close block

- `a%` an any block.
- `1a%` an open-to-close block. Includes mids but does not include open
  and close words.
- `{count}a%` if `{count}` is greater than 1, the `{count}`th surrounding
  open-to-close block.

See [here](#line-wise-operatortext-object-combinations)
for some examples and important special cases.

## function custom text objects [more info](https://github.com/kana/vim-textobj-function/blob/master/README.md)

- `daf` to <strong>D</strong>elete <strong>A</strong> <strong>F</strong>unction, and
- `vif` to <strong>V</strong>isually select the code <strong>I</strong>nside a <strong>F</strong>unction.

* `yaF` to <strong>Y</strong>ank <strong>A</strong> <strong>F</strong>unction with leading or trailing blank lines, and
* `viF` to visually select a function without leading or trailing blank lines.
