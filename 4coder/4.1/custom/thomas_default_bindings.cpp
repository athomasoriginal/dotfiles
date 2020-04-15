/*
thomas_default_bidings.cpp - Supplies the default bindings used for default
4coder behavior.
*/

// TOP

#if !defined(FCODER_DEFAULT_BINDINGS_CPP)
#define FCODER_DEFAULT_BINDINGS_CPP
#include <iostream>

#include "4coder_default_include.cpp"

// NOTE(allen): Users can declare their own managed IDs here.
#include "generated/managed_id_metadata.cpp"

// NOTE(thomas): custom layer imports begin heres
#include "thomas_default_hooks.cpp"

void
custom_layer_init(Application_Links *app){
    Thread_Context *tctx = get_thread_context(app);

    // NOTE(allen): setup for default framework
    default_framework_init(app);

    // NOTE(allen): default hooks and command maps
    set_all_default_hooks(app);
    set_custom_hook(app, HookID_BeginBuffer, thomas_begin_buffer);

    // NOTE(thomas): Allens stuff
    mapping_init(tctx, &framework_mapping);
    setup_default_mapping(&framework_mapping, mapid_global, mapid_file, mapid_code);

}

#endif //FCODER_DEFAULT_BINDINGS

// BOTTOM
