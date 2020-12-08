# neovim configuration 

## Important Information

All of my mappings are structure around the asumption that the `caps lock` key is remapped as `Ctrl`,
that's how old keyboard use to work and i find very convenient to have such big key in the home row. i rarely 
use all caps but when i need them i reach for shift.

![](http://www.economyofeffort.com/media/images/sun-keyboard.png)

to remap your `caps lock` to control in MacOs you can follow somehing like [this](https://www.cnet.com/how-to/how-to-change-caps-lock-key-behavior-in-os-x/)
if you are still very attached to your `caps lock` key you can use something like [Karabiner Elements](https://karabiner-elements.pqrs.org/) that let's you have advanced mappings.

## mappings

maybe you will need to run `:UpdateRemotePlugins` in order to the plugins that use python start using your new python support

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

