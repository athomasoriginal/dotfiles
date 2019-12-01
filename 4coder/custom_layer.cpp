// these 4 were added to support the calc parser
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <iostream>

#include "4coder_default_include.cpp"

// added to support calc parse
#define internal static

// ----------------------------------------------------------------------------
// CUSTOM HOOKS EXAMPLE
//
// This is an example of how to init a custom comment block as Allen has done
// and then we bind it to one of our keys
// ----------------------------------------------------------------------------

static void
default_4coder_initialize_impl(Application_Links *app, int32_t override_font_size, bool32 override_hinting)
{
    int32_t part_size = (32 << 20);
    int32_t heap_size = (4 << 20);

    void *part_mem = memory_allocate(app, part_size);
    global_part = make_part(part_mem, part_size);

    void *heap_mem = memory_allocate(app, heap_size);
    heap_init(&global_heap);
    heap_extend(&global_heap, heap_mem, heap_size);

    static const char message[] = ""
                                  "Welcome to " VERSION "\n"
                                  "\n";
    String msg = make_lit_string(message);
    print_message(app, msg.str, msg.size);

    load_folder_of_themes_into_live_set(app, &global_part, "themes");
    load_config_and_apply(app, &global_part, &global_config, override_font_size, override_hinting);

    view_rewrite_loc = managed_variable_create_or_get_id(app, "DEFAULT.rewrite", 0);
    view_next_rewrite_loc = managed_variable_create_or_get_id(app, "DEFAULT.next_rewrite", 0);
    view_paste_index_loc = managed_variable_create_or_get_id(app, "DEFAULT.paste_index", 0);
    view_is_passive_loc = managed_variable_create_or_get_id(app, "DEFAULT.is_passive", 0);
    view_snap_mark_to_cursor = managed_variable_create_or_get_id(app, "DEFAULT.mark_to_cursor", 0);
}

static void
default_4coder_initialize_api(Application_Links *app)
{
    Face_Description command_line_description = get_face_description(app, 0);
    default_4coder_initialize_impl(app, command_line_description.pt_size, command_line_description.hinting);
}

START_HOOK_SIG(custom_default_start)
{
    named_maps = named_maps_values;
    named_map_count = ArrayCount(named_maps_values);

    default_4coder_initialize_api(app);
    default_4coder_side_by_side_panels(app, files, file_count);

    if (global_config.automatically_load_project)
    {
        load_project(app);
    }

    // no meaning for return
    return (0);
}

// ----------------------------------------------------------------------------
// CUSTOM FUNCTION EXAMPLE
//
// This is an example of how to init a custom comment block as Allen has done
// and then we bind it to one of our keys
// ----------------------------------------------------------------------------
static void
write_string_og(Application_Links *app, View_Summary *view, Buffer_Summary *buffer, String string)
{
    buffer_replace_range(app, buffer, view->cursor.pos, view->cursor.pos, string.str, string.size);
    view_set_cursor(app, view, seek_pos(view->cursor.pos + string.size), 1);
}

static void
write_string_api(Application_Links *app, String string)
{
    uint32_t access = AccessOpen;
    View_Summary view = get_active_view(app, access);
    Buffer_Summary buffer = get_buffer(app, view.buffer_id, access);
    write_string_og(app, &view, &buffer, string);
}

static void
write_named_comment_string_OG(Application_Links *app, char *type_string)
{
    char space[512];
    String str = make_fixed_width_string(space);

    String name = global_config.user_name;
    if (name.size > 0)
    {
        append(&str, "// ");
        append(&str, type_string);
        append(&str, "(");
        append(&str, name);
        append(&str, "): ");
    }
    else
    {
        append(&str, "// ");
        append(&str, type_string);
        append(&str, ": ");
    }

    write_string_api(app, str);
}

CUSTOM_COMMAND_SIG(hello)
{
    write_named_comment_string_OG(app, "Thomas");

}

bool is_not_closing_doublequote(char c)
{
    switch (c)
    {
    case '"':
        return false;
    default:
        return true;
    }
}




// ----------------------------------------------------------------------------
// CUSTOM RENDER
//
// LEARNING
//    -> If you leave this blank, nothing renders to the screen
//    -> Just adding `do_core_render(app);` will only render what we type -
//       no highlights, cursors etc - so what was interesting about this is that
//       I thought those items were controlled by the 4coder engine, not so.
//    -> for hexidecimal colors we need to fill out the last few spaces.  e.g.
//       0xFF3396 would become 0xFFFF339696.  This confuses me.  Maybe we really
//       only have  limited set of colors to work with.
// ----------------------------------------------------------------------------

struct tokenizer
{
    char *At;
};

inline bool
IsNumeric(char C)
{
    bool Result = ((C >= '0') && (C <= '9'));

    return(Result);
}


inline bool
IsEndOfLine(char C)
{
    bool Result = ((C == '\n') ||
                   (C == '\r'));

    return(Result);
}


inline bool
IsWhitespace(char C)
{
    bool Result = ((C == ' ') ||
                   (C == '\t') ||
                   (C == '\v') ||
                   (C == '\f') ||
                   IsEndOfLine(C));

    return(Result);
}

RENDER_CALLER_SIG(thomas_render_caller){

  View_Summary view = get_active_view(app, AccessAll);
  Buffer_Summary buffer = get_buffer(app, view.buffer_id, AccessAll);
  bool32 is_active_view = (view.view_id == view_id);

  static Managed_Scope render_scope = 0;

  if (render_scope == 0){
    render_scope = create_user_managed_scope(app);
  }

  Partition *scratch = &global_part;

  // NOTE(allen): Scan for TODOs and NOTEs
  // Find the things, store them in memory and highlight them
  {
      Theme_Color colors[2];
      colors[0].tag = Stag_Text_Cycle_2;
      colors[1].tag = Stag_Text_Cycle_1;
      get_theme_colors(app, colors, 2);

      Temp_Memory temp = begin_temp_memory(scratch);
      int32_t text_size = on_screen_range.one_past_last - on_screen_range.first;
      // NOTE(thomas) The actual characters in all open buffers appears here
      char *text = push_array(scratch, char, text_size);
      // NOTE(thomas) Take the contents of the buffer and add it to the `text` variable
      buffer_read_range(app, &buffer, on_screen_range.first, on_screen_range.one_past_last, text);

      // fprintf(stdout, "%s\n", text);
      // fprintf(stdout, "%s\n", buffer.file_name);

      Highlight_Record *records = push_array(scratch, Highlight_Record, 0);
      String tail = make_string(text, text_size);

      // fprintf(stdout, "%s\n", tail.str += 3);

      // NOTE(thomas): WIP - only perform highlighting in the current view
      // (window) because we want to limit how much noice to get an understanding
      // of how this works.
      if (is_active_view) {
        tokenizer Tokenizer = {text};

        for (int32_t i = 0; i < text_size; tail.str += 1, tail.size -= 1, i += 1){
          switch(Tokenizer.At[i]) {
            case ';': {
              // until we reach the end of the file or the end of a line, make everything in a line a comment
              int32_t tick = i;
              while (Tokenizer.At[tick] != '\0') {
                ++tick;
                if (Tokenizer.At[tick] == '\n') {
                  // if we type `jkl` and then `\n` and then `; jkl` we want the
                  // color to start on `;` which is what first + i is and we want
                  // the highlight to go until the end of `;jkl` which is
                  // i + the length of `;jkl`.
                  int32_t finaltick = tick - i;
                  Highlight_Record *record = push_array(scratch, Highlight_Record, 1);
                  record->first = i + on_screen_range.first; // the letter to start the color on
                  record->one_past_last = record->first + finaltick; // the letter to end the color on
                  record->color = 0xFF6AC000; // red
                  tail.str += finaltick;
                  tail.size -= finaltick;
                  i += finaltick;
                  break;
                }
              }
            }
            case '"': {
              int32_t tick = i;
              ++tick; // or else we get stuck on the one we were just on
              while(is_not_closing_doublequote(Tokenizer.At[tick])) {
                ++tick;
              }

              ++tick; // or else we get stuck on the one before the last

              int32_t finaltick = tick - i;
              Highlight_Record *record = push_array(scratch, Highlight_Record, 1);
              record->first = i + on_screen_range.first; // the letter to start the color on
              record->one_past_last = record->first + finaltick; // the letter to end the color on
              record->color = 0xFFFF0000; // green
              tail.str += finaltick;
              tail.size -= finaltick;
              i += finaltick;

              break;
            }
            case 'a':
            case 'b':
            case 'c':
            case 'd':
            case 'e':
            case 'f':
            case 'g':
            case 'h':
            case 'i':
            case 'j':
            case 'k':
            case 'l':
            case 'm':
            case 'n':
            case 'o':
            case 'p':
            case 'q':
            case 'r':
            case 's':
            case 't':
            case 'u':
            case 'v':
            case 'w':
            case 'x':
            case 'y':
            case 'z':
            case 'A':
            case 'B':
            case 'C':
            case 'D':
            case 'E':
            case 'F':
            case 'G':
            case 'H':
            case 'I':
            case 'J':
            case 'K':
            case 'L':
            case 'M':
            case 'N':
            case 'O':
            case 'P':
            case 'Q':
            case 'R':
            case 'S':
            case 'T':
            case 'U':
            case 'V':
            case 'W':
            case 'X':
            case 'Y':
            case 'Z': {
              Highlight_Record *record = push_array(scratch, Highlight_Record, 1);
              record->first = i + on_screen_range.first;
              record->one_past_last = record->first + 1;
              record->color = 0xFF0044FF; // light gray
              break;
            }
            default:
            {} break;
          }
        }
      }

      int32_t record_count = (int32_t)(push_array(scratch, Highlight_Record, 0) - records);
      push_array(scratch, Highlight_Record, 1);

      if (record_count > 0){
          sort_highlight_record(records, 0, record_count);
          Temp_Memory marker_temp = begin_temp_memory(scratch);
          Marker *markers = push_array(scratch, Marker, 0);
          int_color current_color = records[0].color;
          {
              Marker *marker = push_array(scratch, Marker, 2);
              marker[0].pos = records[0].first;
              marker[1].pos = records[0].one_past_last;
          }
          for (int32_t i = 1; i <= record_count; i += 1){
              bool32 do_emit = i == record_count || (records[i].color != current_color);
              if (do_emit){
                  int32_t marker_count = (int32_t)(push_array(scratch, Marker, 0) - markers);
                  Managed_Object o = alloc_buffer_markers_on_buffer(app, buffer.buffer_id, marker_count, &render_scope);
                  managed_object_store_data(app, o, 0, marker_count, markers);
                  Marker_Visual v = create_marker_visual(app, o);
                  marker_visual_set_effect(app, v,
                                           VisualType_CharacterHighlightRanges,
                                           SymbolicColor_Transparent, current_color, 0);
                  marker_visual_set_priority(app, v, VisualPriority_Lowest);
                  end_temp_memory(marker_temp);
                  current_color = records[i].color;
              }

              Marker *marker = push_array(scratch, Marker, 2);
              marker[0].pos = records[i].first;
              marker[1].pos = records[i].one_past_last;
          }
      }

      end_temp_memory(temp);
  }

  // NOTE(allen): Cursor and mark
  Managed_Object cursor_and_mark = alloc_buffer_markers_on_buffer(app, buffer.buffer_id, 2, &render_scope);
  Marker cm_markers[2] = {};
  cm_markers[0].pos = view.cursor.pos;
  cm_markers[1].pos = view.mark.pos;
  managed_object_store_data(app, cursor_and_mark, 0, 2, cm_markers);

  // Highlight the cursor
  bool32 cursor_is_hidden_in_this_view = (cursor_is_hidden && is_active_view);
  if (!cursor_is_hidden_in_this_view){
      switch (fcoder_mode){
          case FCoderMode_Original:
          {
              Theme_Color colors[2] = {};
              colors[0].tag = Stag_Cursor;
              colors[1].tag = Stag_Mark;
              get_theme_colors(app, colors, 2);
              int_color cursor_color = SymbolicColorFromPalette(Stag_Cursor);
              int_color mark_color   = SymbolicColorFromPalette(Stag_Mark);
              int_color text_color    = is_active_view?
                  SymbolicColorFromPalette(Stag_At_Cursor):SymbolicColorFromPalette(Stag_Default);

              Marker_Visual_Take_Rule take_rule = {};
              take_rule.first_index = 0;
              take_rule.take_count_per_step = 1;
              take_rule.step_stride_in_marker_count = 1;
              take_rule.maximum_number_of_markers = 1;

              Marker_Visual visual = create_marker_visual(app, cursor_and_mark);
              Marker_Visual_Type type = is_active_view?VisualType_CharacterBlocks:VisualType_CharacterWireFrames;
              marker_visual_set_effect(app, visual,
                                       type, cursor_color, text_color, 0);
              marker_visual_set_take_rule(app, visual, take_rule);
              marker_visual_set_priority(app, visual, VisualPriority_Highest);

              visual = create_marker_visual(app, cursor_and_mark);
              marker_visual_set_effect(app, visual,
                                       VisualType_CharacterWireFrames, mark_color, 0, 0);
              take_rule.first_index = 1;
              marker_visual_set_take_rule(app, visual, take_rule);
              marker_visual_set_priority(app, visual, VisualPriority_Highest);
          }break;

          case FCoderMode_NotepadLike:
          {
              Theme_Color colors[2] = {};
              colors[0].tag = Stag_Cursor;
              colors[1].tag = Stag_Highlight;
              get_theme_colors(app, colors, 2);
              int_color cursor_color    = SymbolicColorFromPalette(Stag_Cursor);
              int_color highlight_color = SymbolicColorFromPalette(Stag_Highlight);

              Marker_Visual_Take_Rule take_rule = {};
              take_rule.first_index = 0;
              take_rule.take_count_per_step = 1;
              take_rule.step_stride_in_marker_count = 1;
              take_rule.maximum_number_of_markers = 1;

              Marker_Visual visual = create_marker_visual(app, cursor_and_mark);
              marker_visual_set_effect(app, visual, VisualType_CharacterIBars, cursor_color, 0, 0);
              marker_visual_set_take_rule(app, visual, take_rule);
              marker_visual_set_priority(app, visual, VisualPriority_Highest);

              if (view.cursor.pos != view.mark.pos){
                  visual = create_marker_visual(app, cursor_and_mark);
                  marker_visual_set_effect(app, visual, VisualType_CharacterHighlightRanges, highlight_color, SymbolicColorFromPalette(Stag_At_Highlight), 0);
                  take_rule.maximum_number_of_markers = 2;
                  marker_visual_set_take_rule(app, visual, take_rule);
                  marker_visual_set_priority(app, visual, VisualPriority_Highest);
              }
          }break;
      }
  }

  if (highlight_line_at_cursor && is_active_view){
      Theme_Color color = {};
      color.tag = Stag_Highlight_Cursor_Line;
      get_theme_colors(app, &color, 1);
      uint32_t line_color = color.color;
      Marker_Visual visual = create_marker_visual(app, cursor_and_mark);
      marker_visual_set_effect(app, visual, VisualType_LineHighlights,
                               line_color, 0, 0);
      Marker_Visual_Take_Rule take_rule = {};
      take_rule.first_index = 0;
      take_rule.take_count_per_step = 1;
      take_rule.step_stride_in_marker_count = 1;
      take_rule.maximum_number_of_markers = 1;
      marker_visual_set_take_rule(app, visual, take_rule);
      marker_visual_set_priority(app, visual, VisualPriority_Highest);
  }

  // NOTE(allen): Token highlight setup
  bool32 do_token_highlight = true;
  if (do_token_highlight){
      Theme_Color color = {};
      color.tag = Stag_Cursor;
      get_theme_colors(app, &color, 1);
      uint32_t token_color = (0x50 << 24) | (color.color&0xFFFFFF);

      uint32_t token_flags = BoundaryToken|BoundaryWhitespace;
      int32_t pos0 = view.cursor.pos;
      int32_t pos1 = buffer_boundary_seek(app, &buffer, pos0, DirLeft , token_flags);
      int32_t pos2 = buffer_boundary_seek(app, &buffer, pos1, DirRight, token_flags);

      Managed_Object token_highlight = alloc_buffer_markers_on_buffer(app, buffer.buffer_id, 2, &render_scope);
      Marker range_markers[2] = {};
      range_markers[0].pos = pos1;
      range_markers[1].pos = pos2;
      managed_object_store_data(app, token_highlight, 0, 2, range_markers);
      Marker_Visual visual = create_marker_visual(app, token_highlight);
      marker_visual_set_effect(app, visual,
                               VisualType_CharacterHighlightRanges,
                               token_color, SymbolicColorFromPalette(Stag_At_Highlight), 0);
  }

  do_core_render(app);
  managed_scope_clear_self_all_dependent_scopes(app, render_scope);
}


// ----------------------------------------------------------------------------
// SETUP
//
// this is exactly the same as what we would find in 4coder_default_bindings.cpp
// until aftter the default_keys bit.  At that point, our custom code takes over
// ----------------------------------------------------------------------------

extern "C" int32_t
get_bindings(void *data, int32_t size)
{
    Bind_Helper context_ = begin_bind_helper(data, size);
    Bind_Helper *context = &context_;

    // call all the default hooks specified by the custom layer provided by
    // 4ed out of the box so we don't have to respecify them, but not sure if
    // we actually need to re-call these and then below this we can overwrite
    // as we go.
    set_all_default_hooks(context);

    // custom hooks here
    set_start_hook(context, custom_default_start);
    set_render_caller(context, thomas_render_caller);


#if defined(__APPLE__) && defined(__MACH__)
    mac_default_keys(context);
#else
    default_keys(context);
#endif

    // custom remapping of 4coder keys begins here
    begin_map(context, mapid_global);
    {
        // was previously `o`
        bind(context, 'p', MDFR_CMND, hello);
    }
    end_map(context);
    // END OF CUSTOM MAC KEY BINDING TEST

    int32_t result = end_bind_helper(context);
    return (result);
}
