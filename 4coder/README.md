# 4Coder 4.1.4 Customization Layer

Welcome to my 4Coder customization layer.  I can't use 4Coder just yet for regular coding because 4Coder is focused on C++ and how and I professionally work with lisp...hence this customization layer.  This guide is for macos.

- [Motivation]
- [Housekeeping]
- [Quickstart]
- [Directory Structure]
- [Customization Layer Setup]
- [Developing Customization Layer]
  - [Debugging Customization Layer]
- [4Coder Gotchas]

## Motivation

- Tired of bloated editors with poor performance
- Interested in learning lower level language

## Customizations

- [ ] Solarized theme
- [ ] Clojure Syntax Highlighter

## Housekeeping

- [Download Paid Version of 4Coder] to use this layer

- Move 4Coder from your Downloads directory to your

  ```bash
  mv ~/Downloads/4coder ~/4coder
  ```

- setup an alias to `4ed` folder in your `.zshrc`

## Quickstart

- Open your favorite terminal

- Move into 4coder directory

  ```bash
  4ed
  ```

- run 4coder

  ```bash
  ./4ed
  ```

  > First time you run on mac, you will get a security warning.  Open `Security & Privacy` settings.  Click `Allow Anyway`.  Run `./4ed` again.  You will get another security warning.  Select `Open`.  Also Note that as of now `4coder` is shipped as a `unix executable` or `binary` file which means that you cannot just double click on the icon and run it.  This is why we open a terminal window and run it as a process there.

## Directory Structure

```bash
.
├── 4.0
│   ├── custom_layer.cpp
│   └── lexer.cpp
├── 4.1
│   └── thomas_customization_layer.cpp
├── README.md
└── dev-journal.md
```

- `4.*` are customization layers based on the version of 4coder I was using.

## Customization Layer Setup

Guide for setting up this customization layer

- move into

  ```
  4ed
  ```

  > The above is an alias I set during the housekeeping steps

- build customization layer (sanity check)

  ```bash
  `./custom/bin/buildsuper_x64-mac.sh`
  ```

  > Run this from within the `4coder` dir. We are just making sure that we can build 4coder as we expect.  This will generate folders and files: `custom/metadata_generator.dSYM/Contents/Resources/DWARF/metadata_generator` & `custom_4coder.so`.

- create a home for your 4Coder customization layer

  ```
  mkdir ~/dotfiles/4coder
  ```

  > I store my layer in my dotfiles.  The reason to create a layer folder and not just add to 4coder is to make it easier when you update your versions of 4coder.

- Add an alias to the `4Coder` customization directory

  ```bash
  alias 4coder="dotfiles/4coder"
  ```

  > This is just for quick access

- create an entry point for your customization layer

  ```bash
  touch ~/dotfiles/4coder/4.1/thomas_custom_layer.cpp
  ```

  > Note that I prefix mine with `thomas` just to make it abundantly clear.

- symlink the `custom_layer.cpp` code from dotfiles to the `4coder` app dir

  ```bash
  ln -s ~/dotfiles/4coder/4.1/thomas_custom_layer.cpp ~/4coder/custom_layer.cpp
  ```

  > This is how we get our custom layer inside of the 4coder app

- Initial `custom_layer` setup:

  Copy `4coder_default_bidings.cpp` into your custom layer.  This is how you init your own custom layer.

- build customization layer

  ```bash
  ./custom/bin/buildsuper_x64-mac.sh custom_layer.cpp
  ```

## Developing Customization Layer

Guide for how to develop on this customization layer

### Code Changes

You change the code in your working customization layer directory.  As I mentioned, I keep mine outside of the 4coder app itself and in a directory in these dotfiles called `dotfiles/4coder/4.1/thomas_custom_layer.cpp`.

### Build Changes

- Build custom Layer

  ```bash
  ./custom/bin/buildsuper_x64-mac.sh custom_layer.cpp
  ```

### Debugging Customization Layer

- using vscode I setup tasks and debug line

- open `4Coder` core app inside of vscode

## 4Coder Gotchas

- new syntax highlight requires updating 4coder.config

## API Guide

- `accessAll` - the command you specify works on protected and non-protected buffers
- `accessOpen` - the command only allowed to get to open buffers
- `buffer_set_setting` - used to set a buffers map setting

## Resources

- [Clojure Parser in C++]
- [Lexer Faster When not Regex]
- [PEG - modern approach]
- [Github Lexers]
- [Nice lexer v parser intro]
- [Lexer from Scratch in Python - good stuff]
- [Guide 1]
- [Guide 2]



[Motivation]: #motivation
[Housekeeping]: #Housekeeping
[Quickstart]: Quickstart
[Directory Structure]: #Directory-Structure
[Customization Layer Setup]: #Customization-Layer-Setup
[Developing Customization Layer]: #Developing-Customization-Layer
[Debugging Customization Layer]: #Debugging-Customization-Layer
[4Coder Gotchas]: #4Coder-Gotchas
[Download Paid Version of 4Coder]: https://4coder.itch.io/

[Clojure Parser in C++]: https://github.com/WillDetlor/TinyClojure/blob/master/src/TinyClojure.cpp
[Lexer Faster When not Regex]: https://eli.thegreenplace.net/2013/07/16/hand-written-lexer-in-javascript-compared-to-the-regex-based-ones
[PEG - modern approach]: https://en.wikipedia.org/wiki/Parsing_expression_grammar
[Github Lexers]: https://github.com/topics/lexer
[Nice lexer v parser intro]: https://qscintilla.com/lexer-basics/
[Lexer from Scratch in Python - good stuff]: https://www.youtube.com/watch?v=LDDRn2f9fUk
[Guide 1]: https://blog.klipse.tech/javascript/2017/02/08/tiny-compiler-tokenizer.html
[Guide 2]: https://blog.klipse.tech/javascript/2017/02/08/tiny-compiler-parser.html
