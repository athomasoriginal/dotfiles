/*
thomas_default_hooks.cpp - Sets up the hooks for the default framework.
*/

BUFFER_HOOK_SIG(thomas_begin_buffer){
    ProfileScope(app, "Thomas begin buffer");

    Scratch_Block scratch(app);

    b32 treat_as_code         = false;
    String_Const_u8 file_name = push_buffer_file_name(app, scratch, buffer_id);

    if (file_name.size > 0){
      // TODO What value does this product?
      String_Const_u8_Array extensions = global_config.code_exts;
      String_Const_u8 ext              = string_file_extension(file_name);

      // Check if extensions should be read as code
      for (i32 i = 0; i < extensions.count; ++i){
        if (string_match(ext, extensions.strings[i])){

          if (string_match(ext, string_u8_litexpr("cpp")) ||
              string_match(ext, string_u8_litexpr("h"))   ||
              string_match(ext, string_u8_litexpr("c"))   ||
              string_match(ext, string_u8_litexpr("hpp")) ||
              string_match(ext, string_u8_litexpr("clj"))) {
              treat_as_code = true;
          }

#if 0
          treat_as_code = true;

          // c++
          if (string_match(ext, string_u8_litexpr("cpp")) ||
              string_match(ext, string_u8_litexpr("h")) ||
              string_match(ext, string_u8_litexpr("c")) ||
              string_match(ext, string_u8_litexpr("hpp")) ||
              string_match(ext, string_u8_litexpr("cc"))){
              if (parse_context_language_cpp == 0){
                  init_language_cpp(app);
              }
              parse_context_id = parse_context_language_cpp;
          }
#endif

          break;
        }
      }
    }

    Command_Map_ID map_id      = (treat_as_code)?(mapid_code):(mapid_file);
    Managed_Scope scope        = buffer_get_managed_scope(app, buffer_id);
    Command_Map_ID *map_id_ptr = scope_attachment(app, scope, buffer_map_id, Command_Map_ID);
    *map_id_ptr                = map_id;

    Line_Ending_Kind setting      = guess_line_ending_kind_from_buffer(app, buffer_id);
    Line_Ending_Kind *eol_setting = scope_attachment(app, scope, buffer_eol_setting, Line_Ending_Kind);
    *eol_setting                  = setting;

    // NOTE(allen): Decide buffer settings
    b32 wrap_lines = true;
    b32 use_lexer  = false;
    if (treat_as_code){
        wrap_lines = global_config.enable_code_wrapping;
        use_lexer  = true;
    }

    String_Const_u8 buffer_name = push_buffer_base_name(app, scratch, buffer_id);
    if (string_match(buffer_name, string_u8_litexpr("*compilation*"))){
        wrap_lines = false;
    }

    if (use_lexer){
        ProfileBlock(app, "begin buffer kick off lexer");
        Async_Task *lex_task_ptr = scope_attachment(app, scope, buffer_lex_task, Async_Task);
        *lex_task_ptr = async_task_no_dep(&global_async_system, do_full_lex_async, make_data_struct(&buffer_id));
    }

    {
        b32 *wrap_lines_ptr = scope_attachment(app, scope, buffer_wrap_lines, b32);
        *wrap_lines_ptr = wrap_lines;
    }

    if (use_lexer){
        buffer_set_layout(app, buffer_id, layout_virt_indent_index_generic);
    }
    else{
        if (treat_as_code){
            buffer_set_layout(app, buffer_id, layout_virt_indent_literal_generic);
        }
        else{
            buffer_set_layout(app, buffer_id, layout_generic);
        }
    }


    // no meaning for return
    return 0;
}
