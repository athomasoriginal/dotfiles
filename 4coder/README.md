# 4Coder Customization Layer

This is my 4Coder customization layer.  Please note that it is incomplete and I do not use 4Coder on a daily basis.  This is more of a pet project while I wait/work alongside 4Coder to a point where I feel I can switch off of my current editor.

## Quickstart - Running 4Coder

> The following is where I currently store 4Coder

- download `4coder` paid version

- move the `4coder` from the `Downloads` dir to home dir

- setup an alias to `4coder` folder in your `.zshrc`

- running `4ed`: `./4ed`

  > `4ed` is the file you will run.  It is a `unix executable` or `binary` file which means that you cannot just double click on the icon.


## Quick Start - Customization Layer

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


## QuickStart - Developing Customization Layer

This section will outline how I develop the customization layer.

- All code changes are made in my `4coder` dir.
- Test code changes by running `./buildsuper.sh custom_layer.cpp` from within `4coder` core dir
- To see everything running run `./4ed` from within `4coder` core dir


## QuickStart - Debuggin Customization Layer

- using vscode I setup tasks and debug line
- open `4Coder` core app inside of vscode


## Gotchas

- new syntax highlight requires updating 4coder.config also

## API Guide

- `accessAll` - the command you specify works on protected and non-protected buffers
- `accessOpen` - the command only allowed to get to open buffers
- `buffer_set_setting` - used to set a buffers map setting

## Resources

- [Clojure Parser in C++](https://github.com/WillDetlor/TinyClojure/blob/master/src/TinyClojure.cpp)
- [Lexer Faster When not Regex](https://eli.thegreenplace.net/2013/07/16/hand-written-lexer-in-javascript-compared-to-the-regex-based-ones)
- [PEG - modern approach](https://en.wikipedia.org/wiki/Parsing_expression_grammar)
- [Github Lexers](https://github.com/topics/lexer)
- [Nice lexer v parser intro](https://qscintilla.com/lexer-basics/)
- [Lexer from Scratch in Python - really good stuff](https://www.youtube.com/watch?v=LDDRn2f9fUk)
