# 4Coder 4.1.4 Customization Layer

Welcome to my 4Coder customization layer.  I can't use 4Coder just yet for regular coding because 4Coder is focused on C++ and how and I professionally work with lisp...hence this customization layer.  This guide is for macos.

- [Motivation]
- [Housekeeping]
- [Quickstart]
- [Customization Layer Setup]
- [Developing Customization Layer]
  - [Debugging Customization Layer]
- [4Coder Gotchas]

## Motivation

- Tired of bloated editors with poor performance
- Interested in learning lower level language

## Housekeeping

- [Download Paid Version of 4Coder] to use this layer

- Move 4Coder from your Downloads directory to your

  ```bash
  mv ~/Downloads/4coder ~/4coder
  ```

- setup an alias to `4ed` folder in your `.zshrc`

## Quickstart

- Open your favorite terminal

- Move into `4ed`

  ```bash
  4ed
  ```

- run 4coder

  ```bash
  ./4ed
  ```

  > First time you run on mac, you will get a security warning.  Open `Security & Privacy` settings.  Click `Allow Anyway`.  Run `./4ed` again.  You will get another security warning.  Select `Open`.  Also Note that as of now `4coder` is shipped as a `unix executable` or `binary` file which means that you cannot just double click on the icon and run it.  This is why we open a terminal window and run it as a process there.


## Customization Layer Setup

Guide for setting up this customization layer

- move into `4Coder`

- sanity check: run `./buildsuper.bat`

  > Run this from within the `4coder` dir. We are just making sure that everything is working as expected.

- create a directory to store you 4Coder customization layer

  > I co-located mine with my dotfiles because I want to have them available across all of my machines.

- Add an alias to the `4Coder` customization directory

  > This is just for quick access

- create a file called `custom_layer.cpp` inside of your custom `4coder` dir you created above

- symlink the `custom_layer.cpp` code from dotfiles to the `4coder` app dir

  ```bash
  ln -s ~/dotfiles/4coder/custom_layer.cpp ~/4coder/custom_layer.cpp
  ```

- Setup the `custom_layer` file to look like this:

  ```c
  #include "4coder_default_include.cpp"

  // this is exactly the same as what we would find in 4coder_default_bindings.cpp
  // until aftter the default_keys bit.  At that point, our custom code takes over
  extern "C" int32_t
  get_bindings(void *data, int32_t size){
      Bind_Helper context_ = begin_bind_helper(data, size);
      Bind_Helper *context = &context_;

      set_all_default_hooks(context);

  #if defined(__APPLE__) && defined(__MACH__)
      mac_default_keys(context);
  #else
      default_keys(context);
  #endif

      // custom remapping of 4coder keys begins here
      begin_map( context, mapid_global );
      {
          // was previously `o`
          bind(context, 'p', MDFR_CMND, interactive_open_or_new);
      }
      end_map( context );
      // END OF CUSTOM MAC KEY BINDING TEST

      int32_t result = end_bind_helper(context);
      return(result);
  }
  ```

- run the `./buildsuper.sh` from the `4ed` app dir

  ```bash
  ./buildsuper.sh custom_layer.cpp
  ```

The above should build and then when you press `alt + p` you should see the `open` lister open up.

**NOTE** The downside of symlinking is that each time you get a new version of 4Coder you will have to re-link your customization layer.


## Developing Customization Layer

Guide for how to develop on this customization layer

- All code changes are made in my `4coder` dir.
- Test code changes by running `./buildsuper.sh custom_layer.cpp` from within `4coder` core dir
- To see everything running run `./4ed` from within `4coder` core dir


### Debugging Customization Layer

- using vscode I setup tasks and debug line
- open `4Coder` core app inside of vscode

## 4Coder Gotchas

- new syntax highlight requires updating 4coder.config also

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
[Customization Layer Setup]: #Customization-Layer-Setup
[Developing Customization Layer]: #Developing-Customization-Layer
[Debugging Customization Layer]: #Debugging-Customization-Layer
[4Coder Gotchas]: #4Coder-Gotchas
[Download Paid 4Coder]: https://4coder.itch.io/

[Clojure Parser in C++]: https://github.com/WillDetlor/TinyClojure/blob/master/src/TinyClojure.cpp
[Lexer Faster When not Regex]: https://eli.thegreenplace.net/2013/07/16/hand-written-lexer-in-javascript-compared-to-the-regex-based-ones
[PEG - modern approach]: https://en.wikipedia.org/wiki/Parsing_expression_grammar
[Github Lexers]: https://github.com/topics/lexer
[Nice lexer v parser intro]: https://qscintilla.com/lexer-basics/
[Lexer from Scratch in Python - good stuff]: https://www.youtube.com/watch?v=LDDRn2f9fUk
[Guide 1]: https://blog.klipse.tech/javascript/2017/02/08/tiny-compiler-tokenizer.html
[Guide 2]: https://blog.klipse.tech/javascript/2017/02/08/tiny-compiler-parser.html
