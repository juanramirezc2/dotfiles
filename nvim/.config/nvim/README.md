# neovim configuration 

## Important Information

All of my mappings are structure around the asumption that the `caps lock` key is remapped as `Ctrl`,
that's how old keyboard use to work and i find very convenient to have such big key in the home row. i rarely 
use all caps but when i need them i reach for shift.

![](http://www.economyofeffort.com/media/images/sun-keyboard.png)

to remap your `caps lock` to control in MacOs you can follow somehing like [this](https://www.cnet.com/how-to/how-to-change-caps-lock-key-behavior-in-os-x/)
if you are still very attached to your `caps lock` key you can use something like [Karabiner Elements](https://karabiner-elements.pqrs.org/) that let's you have advanced mappings.

## Plugins

My configuration in centered around the FrontEnd development stack (`typescript`,`react`,`styled-components`,`flow`), not worries if this isn't your stack
i have detailed comments in my config so you can tweak it according to your needs.

[Coc](https://github.com/neoclide/coc.nvim) (conquer of completion) is the main plugin in my config, this plugin bring features from VSCode to vim users
things like autocompletion, diagnostics, Intellisense and more.

[Denite](https://github.com/Shougo/denite.nvim)  is a plugin that help me when browsing my code, this plugin brings recursive search using fuzzy completion
being aware of ignoring files from `.gitignore`

[Nerdtree](https://github.com/preservim/nerdtree) this plugin bring me a folder structure that i browse.

## Themes

![](https://raw.githubusercontent.com/juangabrielr4/dotfiles/master/nvim/.config/nvim/themes.gif)
I'm the kind of person that get bored of the monotony that's why i created a script inside my neovim config that load a ramdom
[Base 16 theme](https://github.com/chriskempson/base16) every time i open `Neovim` :D 


## Mappings
My `leader` key is `space` (inspired by spacemacs) this means that most of my custom mappins use this key.


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

```

```

