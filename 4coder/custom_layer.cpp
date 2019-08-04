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
