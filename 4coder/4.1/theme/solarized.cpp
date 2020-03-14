// Solarized theme borrowed and modified from https://github.com/clearfeld/4coder-package-solarized-themes/blob/master/solarized_themes.cpp

static bool global_solarized_dark_mode = 1;

static void
solarized_light_theme(Application_Links *app)
{
    Color_Table *table = &active_color_table;
    Arena *arena = &global_theme_arena;
    linalloc_clear(arena);
    *table = make_color_table(app, arena);

    global_solarized_dark_mode = 0;

    u32 solarized_background                   = 0xFFFDF6E3;
    u32 solarized_background_filebar           = 0xFFEEE8D5;
    u32 solarized_number                       = 0xFF6C71C4;
    u32 solarized_keyword                      = 0xFF859900;
    u32 solarized_string                       = 0xFF2AA198;
    u32 solarized_include                      = 0xFF268BD2;
    u32 solarized_preproc                      = 0xFF268BD2;
    u32 solarized_comment                      = 0xFF586E75;

    u32 solarized_highlight_enclosing_scopes_1 = 0xFFFDF6E3;
    u32 solarized_highlight_enclosing_scopes_2 = 0xFFF0E9D6;
    u32 solarized_highlight_enclosing_scopes_3 = 0xFFE4DDCA;
    u32 solarized_highlight_enclosing_scopes_4 = 0xFFD7D0BD;

    u32 solarized_highlight_pair_scopes_1      = 0xFF33FF99;
    u32 solarized_highlight_pair_scopes_2      = 0xFF33FFFF;
    u32 solarized_highlight_pair_scopes_3      = 0xFFFF33FF;
    u32 solarized_highlight_pair_scopes_4      = 0xFFFF3399;

    u32 solarized_ui_lister_mouse_hover        = 0xFF859900;
    u32 solarized_highlight_current_line       = 0xFFEEE8D5;
    u32 solarized_inactive                     = 0xFFF0F2EE;
    u32 solarized_text                         = 0xFF839496;

    u32 solarized_orange                       = 0xFFCB4B16;
    u32 solarized_white                        = 0xFFFCFCFC;
    u32 solarized_green                        = 0xff859900;
    u32 solarized_red                          = 0xFFFF2A2A;

    u32 solarized_defcolor_at_cursor           = 0xFFFCFCFC;
    u32 solarized_base1                        = 0xff93a1a1;

    u32 comment_note_green                     = 0xFF00FF00;

    // Filebar
    table->arrays[defcolor_bar]                   = make_colors(arena, solarized_background_filebar);
    table->arrays[defcolor_base]                  = make_colors(arena, solarized_base1);

    // Background
    table->arrays[defcolor_back]                  = make_colors(arena, solarized_background);

    // Profiler
    table->arrays[defcolor_margin]                = make_colors(arena, solarized_inactive);
    table->arrays[defcolor_margin_hover]          = make_colors(arena, solarized_background_filebar);
    table->arrays[defcolor_margin_active]         = make_colors(arena, solarized_ui_lister_mouse_hover);

    // Profiler & Lister Items
    table->arrays[defcolor_pop1]                  = make_colors(arena, solarized_orange);
    table->arrays[defcolor_pop2]                  = make_colors(arena, solarized_green);

    // Lister
    table->arrays[defcolor_list_item]             = make_colors(arena, solarized_inactive);
    table->arrays[defcolor_list_item_hover]       = make_colors(arena, solarized_green);
    table->arrays[defcolor_list_item_active]      = make_colors(arena, solarized_ui_lister_mouse_hover);

    // Cursor and char under cursor colors
    table->arrays[defcolor_cursor]                = make_colors(arena, solarized_red);
    table->arrays[defcolor_at_cursor]             = make_colors(arena, solarized_defcolor_at_cursor);

    //
    table->arrays[defcolor_highlight_cursor_line] = make_colors(arena, solarized_highlight_current_line);
    table->arrays[defcolor_mark]                  = make_colors(arena, solarized_orange);
    table->arrays[defcolor_text_default]          = make_colors(arena, solarized_text);

    table->arrays[defcolor_keyword]               = make_colors(arena, solarized_keyword);

    table->arrays[defcolor_str_constant]          = make_colors(arena, solarized_string);
    table->arrays[defcolor_char_constant]         = make_colors(arena, solarized_string);

    table->arrays[defcolor_int_constant]          = make_colors(arena, solarized_number);
    table->arrays[defcolor_float_constant]        = make_colors(arena, solarized_number);
    table->arrays[defcolor_bool_constant]         = make_colors(arena, solarized_number);

    table->arrays[defcolor_preproc]               = make_colors(arena, solarized_preproc);
    table->arrays[defcolor_include]               = make_colors(arena, solarized_include);

    // Line numbers fg and bg
    table->arrays[defcolor_line_numbers_back]     = make_colors(arena, solarized_background);
    table->arrays[defcolor_line_numbers_text]     = make_colors(arena, solarized_comment);

    // Search item bg and fg colors
    table->arrays[defcolor_highlight]             = make_colors(arena, solarized_orange);
    table->arrays[defcolor_at_highlight]          = make_colors(arena, solarized_white);

    // comment and keywords in comment
    table->arrays[defcolor_comment]               = make_colors(arena, solarized_comment);
    table->arrays[defcolor_comment_pop]           = make_colors(arena,
                                                                comment_note_green, // NOTE
                                                                solarized_red);     // TODO

    // line wrap \ character
    table->arrays[defcolor_ghost_character]       = make_colors(arena, solarized_orange);

    // ?
    table->arrays[defcolor_special_character]     = make_colors(arena, 0xFF000000);

    // ?
    table->arrays[defcolor_highlight_junk]        = make_colors(arena, 0xFF000000);

    // bg color for decls search items
    table->arrays[defcolor_highlight_white]       = make_colors(arena, 0x77CB4B16);

    // ?
    table->arrays[defcolor_paste]                 = make_colors(arena, 0xFF000000);
    table->arrays[defcolor_undo]                  = make_colors(arena, 0xFF000000);

    // Scope depth background colour
    table->arrays[defcolor_back_cycle]            = make_colors(arena,
                                                                solarized_highlight_enclosing_scopes_1,
                                                                solarized_highlight_enclosing_scopes_2,
                                                                solarized_highlight_enclosing_scopes_3,
                                                                solarized_highlight_enclosing_scopes_4);

    // () [] pair colors
    table->arrays[defcolor_text_cycle]            = make_colors(arena,
                                                                solarized_highlight_pair_scopes_1,
                                                                solarized_highlight_pair_scopes_2,
                                                                solarized_highlight_pair_scopes_3,
                                                                solarized_highlight_pair_scopes_4);
}

CUSTOM_COMMAND_SIG(load_solarized_light_theme)
CUSTOM_DOC("Loads the solarized light theme variant.")
{
    solarized_light_theme(app);
    log_string(app, string_u8_litexpr("Loaded Solarized Light Theme\n"));
}
