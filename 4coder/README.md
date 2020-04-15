# 4Coder 4.1.4 Customization Layer

This is my 4coder customization layer.  It's a complete WIP.  I am posting this for education purposes.  This guide is for macos.

- [Motivation]
- [Customizations]
- [Housekeeping]
- [Quickstart]
- [Upgrading 4coder]
- [Directory Structure]
- [Customization Layer Setup]
- [Developing Customization Layer]
  - [Code Changes]
  - [Build Custom Layer]
  - [Build Lexer]
  - [Debugging Customization Layer]
- [4Coder Gotchas]
- [API Guide]
- [Resources]

## Motivation

- Tired of bloated editors with poor performance
- Interested in learning lower level language

## Customizations

- [ ] Solarized theme
- [ ] Clojure Syntax Highlighter
- [ ] zprint integration - see [Remedy BG Integration]
- [ ] REPL integration

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

## Upgrading 4coder

Given that we customize several files, it's import to track down what we changed:

- Script - `build_one_time.sh` -> `readlink` to `greadlink`
- Hook - `begin_buffer`
- Lexer - `thomas_cpp_lexer_gen.cpp`

## Directory Structure

```bash
.
├── 4.0
│   ├── custom_layer.cpp
│   └── lexer.cpp
├── 4.1
│   ├── thomas_default_hooks.cpp
│   └── thomas_default_bindings.cpp
└── README.md
```

- `4.*` are customization layers by 4coder version
- `thomas_default_hooks` -
- `thomas_default_bindings` - entry point

> Helpful to sync with Allen's naming convention and just prefix differently to sync with the structure he has provided.

## Customization Layer Setup

Guide for setting up this customization layer

- move into 4coder directory

  ```
  4ed
  ```

  > The above is an alias I set during the housekeeping steps

- build customization layer (sanity check)

  ```bash
  `./custom/bin/buildsuper_x64-mac.sh`
  ```

  > Run this from within the `4coder` dir. We are just making sure that we can build 4coder as we expect.  This will generate folders and files: `custom/metadata_generator.dSYM/Contents/Resources/DWARF/metadata_generator` & `custom_4coder.so`.  The above command is if you are a mac user.

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
  touch ~/dotfiles/4coder/4.1/thomas_default_bindings.cpp
  ```

  > Note that I prefix mine with `thomas` just to make it abundantly clear.

- symlink the `default_bindings.cpp` code from dotfiles to the `4coder` app dir

  ```bash
  ln -s ~/dotfiles/4coder/4.1/custom/thomas_default_bindings.cpp ~/4coder/thomas_default_bindings.cpp
  ln -s ~/dotfiles/4coder/4.1/custom/thomas_default_hooks.cpp ~/4coder/custom/thomas_default_hooks.cpp

  ln -s ~/dotfiles/4coder/4.1/languages/thomas_clojure_lexer_gen.cpp ~/4coder/custom/languages/thomas_clojure_lexer_gen.cpp
  ln -s ~/dotfiles/4coder/4.1/languages/thomas_cpp_lexer_gen.cpp ~/4coder/custom/languages/thomas_cpp_lexer_gen.cpp

  ln -s ~/dotfiles/4coder/4.1/build_lang.sh ~/4coder/build_lang.sh
  ```

  > This is how we get our custom layer inside of the 4coder app

- Initial `default_bindings` setup:

  Copy `4coder_default_bidings.cpp` into your custom layer.  This is how you init your own custom layer.

- Build Language Lexers

  ```bash
  ./build_lang.sh
  ```

  > Above might need you to `chmod +x`

- build customization layer

  ```bash
  ./custom/bin/buildsuper_x64-mac.sh thomas_default_bindings.cpp
  ```

## Developing Customization Layer

Guide for how to develop on this customization layer

### Code Changes

You change the code in your working customization layer directory.  As I mentioned, I keep mine outside of the 4coder app itself and in a directory in these dotfiles called `dotfiles/4coder/4.1/thomas_default_bindings.cpp`.

### Build Custom Layer

- Build custom Layer

  ```bash
  ./custom/bin/buildsuper_x64-mac.sh default_bindings.cpp
  ```

### Build The Lexer

**Housekeeping**

I found that the `build_one_time.sh` script did not work out of the box with `readlink` throwing an error like:

```bash
readlink: illegal option -- f
```

So I just installed `coreutils`

```bash
brew install coreutils
```

and then swapped out `readlink` for `greedlink` inside of the `build_one_time.sh` script.

**Quick Guide**

> I was able to discover how to do this through [Skytrias Great 4Coder Customization Video] and you're performing all these commands from the root of the `4coder` editor directory

- Make changes to `4coder_cpp_lexer_gen.cpp`

- Move into the `4coder` app directory

- build generator, run generator and cleanup

  ```bash
  ./build_lang
  ```

  > This is just a helper script I setup to improve the ux when building a specific language

- [Now rebuild your customization layer](#build-custom-layer)

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
- [Remedy BG Integration]

  Example of how to call an outside program



[Motivation]: #motivation
[Customizations]: #customizations
[Housekeeping]: #Housekeeping
[Code Changes]: #code-changes
[Build Custom Layer]: #build-custom-layer
[Build Lexer]: #build-lexer
[Quickstart]: Quickstart
[Directory Structure]: #Directory-Structure
[Customization Layer Setup]: #Customization-Layer-Setup
[Developing Customization Layer]: #Developing-Customization-Layer
[Debugging Customization Layer]: #Debugging-Customization-Layer
[4Coder Gotchas]: #4Coder-Gotchas
[Download Paid Version of 4Coder]: https://4coder.itch.io/
[API Guide]: #api-guide
[Resources]: #resources

[Clojure Parser in C++]: https://github.com/WillDetlor/TinyClojure/blob/master/src/TinyClojure.cpp
[Lexer Faster When not Regex]: https://eli.thegreenplace.net/2013/07/16/hand-written-lexer-in-javascript-compared-to-the-regex-based-ones
[PEG - modern approach]: https://en.wikipedia.org/wiki/Parsing_expression_grammar
[Github Lexers]: https://github.com/topics/lexer
[Nice lexer v parser intro]: https://qscintilla.com/lexer-basics/
[Lexer from Scratch in Python - good stuff]: https://www.youtube.com/watch?v=LDDRn2f9fUk
[Guide 1]: https://blog.klipse.tech/javascript/2017/02/08/tiny-compiler-tokenizer.html
[Guide 2]: https://blog.klipse.tech/javascript/2017/02/08/tiny-compiler-parser.html

[Skytrias Great 4Coder Customization Video]: https://youtu.be/DzTbmleyafY?t=1881
[Remedy BG Integration]: https://gitlab.com/flyingsolomon/4coder_modal/-/blob/master/debugger_remedybg.cpp
