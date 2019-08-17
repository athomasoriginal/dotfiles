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
// CUSTOM FUNCTION EXAMPLE 2
//
// custom parser
// ----------------------------------------------------------------------------

enum token_type
{
    Token_Unknown,

    Token_OpenParen,
    Token_CloseParen,
    Token_Asterisk,
    Token_Minus,
    Token_Plus,
    Token_ForwardSlash,
    Token_Percent,
    Token_Colon,
    Token_Number,
    Token_Comma,

    Token_EndOfStream,
};

struct token
{
    token_type Type;

    size_t TextLength;
    char *Text;
};


struct tokenizer
{
    char *At;
};

enum calc_node_type
{
    CalcNode_UnaryMinus,

    CalcNode_Add,
    CalcNode_Subtract,
    CalcNode_Multiply,
    CalcNode_Divide,
    CalcNode_Mod,

    CalcNode_Constant,
};

struct calc_node
{
    calc_node_type Type;
    double Value;
    calc_node *Left;
    calc_node *Right;
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


static void
EatAllWhitespace(tokenizer *Tokenizer)
{
    for(;;)
    {
        if(IsWhitespace(Tokenizer->At[0]))
        {
            ++Tokenizer->At;
        }
        else if((Tokenizer->At[0] == '/') &&
                (Tokenizer->At[1] == '/'))
        {
            Tokenizer->At += 2;
            while(Tokenizer->At[0] && !IsEndOfLine(Tokenizer->At[0]))
            {
                ++Tokenizer->At;
            }
        }
        else if((Tokenizer->At[0] == '/') &&
                (Tokenizer->At[1] == '*'))
        {
            Tokenizer->At += 2;
            while(Tokenizer->At[0] &&
                  !((Tokenizer->At[0] == '*') &&
                    (Tokenizer->At[1] == '/')))
            {
                ++Tokenizer->At;
            }

            if(Tokenizer->At[0] == '*')
            {
                Tokenizer->At += 2;
            }
        }
        else
        {
            break;
        }
    }
}

static token
GetToken(tokenizer *Tokenizer)
{
    EatAllWhitespace(Tokenizer);

    token Token = {};
    Token.TextLength = 1;
    Token.Text = Tokenizer->At;
    char C = Tokenizer->At[0];
    ++Tokenizer->At;
    switch(C)
    {
        case 0: {--Tokenizer->At; Token.Type = Token_EndOfStream;} break;

        case '(': {Token.Type = Token_OpenParen;} break;
        case ')': {Token.Type = Token_CloseParen;} break;
        case '*': {Token.Type = Token_Asterisk;} break;
        case '-': {Token.Type = Token_Minus;} break;
        case '+': {Token.Type = Token_Plus;} break;
        case '/': {Token.Type = Token_ForwardSlash;} break;
        case '%': {Token.Type = Token_Percent;} break;
        case ':': {Token.Type = Token_Colon;} break;
        case ',': {Token.Type = Token_Comma;} break;

        default:
        {
            if(IsNumeric(C))
            {
                // TODO(casey): Real number
                Token.Type = Token_Number;
                while(IsNumeric(Tokenizer->At[0]) ||
                      (Tokenizer->At[0] == '.') ||
                      (Tokenizer->At[0] == 'f'))
                {
                    ++Tokenizer->At;
                    Token.TextLength = Tokenizer->At - Token.Text;
                }
            }
            else
            {
                Token.Type = Token_Unknown;
            }
        } break;
    }

    return(Token);
}


static token
PeekToken(tokenizer *Tokenizer)
{
    tokenizer Tokenizer2 = *Tokenizer;
    token Result = GetToken(&Tokenizer2);
    return(Result);
}


internal calc_node *
AddNode(calc_node_type Type, calc_node *Left = 0, calc_node *Right = 0)
{
    calc_node *Node = (calc_node *)malloc(sizeof(calc_node));
    Node->Type = Type;
    Node->Value = 0;
    Node->Left = Left;
    Node->Right = Right;
    return(Node);
}

internal calc_node *
ParseNumber(tokenizer *Tokenizer)
{
    calc_node *Result = AddNode(CalcNode_Constant);

    token Token = GetToken(Tokenizer);
    Result->Value = atof(Token.Text);

    return(Result);
}


internal calc_node *
ParseConstant(tokenizer *Tokenizer)
{
    calc_node *Result = 0;

    token Token = PeekToken(Tokenizer);
    if(Token.Type == Token_Minus)
    {
        Token = GetToken(Tokenizer);
        Result = AddNode(CalcNode_UnaryMinus);
        Result->Left = ParseNumber(Tokenizer);
    }
    else
    {
        Result = ParseNumber(Tokenizer);
    }

    return(Result);
}


internal calc_node *
ParseMultiplyExpression(tokenizer *Tokenizer)
{
    calc_node *Result = 0;

    token Token = PeekToken(Tokenizer);
    printf("PARSE?: ParseMultiplyExpression\n");
    printf("TOKEN TYPE: %u\n", Token.Type);
    if((Token.Type == Token_Minus) ||
       (Token.Type == Token_Number))
    {
        Result = ParseConstant(Tokenizer);
        token Token = PeekToken(Tokenizer);
        if(Token.Type == Token_ForwardSlash)
        {
            GetToken(Tokenizer);
            Result = AddNode(CalcNode_Divide, Result, ParseNumber(Tokenizer));
        }
        else if(Token.Type == Token_Asterisk)
        {
            GetToken(Tokenizer);
            Result = AddNode(CalcNode_Multiply, Result, ParseNumber(Tokenizer));
        }
    }

    printf("PASS: NOT GOING TO NEED ParseMultiplyExpression\n");

    return(Result);
}


internal double
ExecCalcNode(calc_node *Node)
{

    double Result = 0.0f;

    if(Node)
    {

        switch(Node->Type)
        {
            case CalcNode_UnaryMinus:
              printf("NODE TYPE: %s\n", "CalcNode_UnaryMinus");
              printf("NODE Value: %f\n", Node->Value);
              {Result = -ExecCalcNode(Node->Left);}
              break;

            case CalcNode_Add:
              printf("NODE TYPE: %s\n", "CalcNode_Add");
              printf("NODE Value: %f\n", Node->Value);
              {Result = ExecCalcNode(Node->Left) + ExecCalcNode(Node->Right);}
              break;

            case CalcNode_Subtract:
              printf("NODE TYPE: %s\n", "CalcNode_Subtract");
              printf("NODE Value: %f\n", Node->Value);
              {Result = ExecCalcNode(Node->Left) - ExecCalcNode(Node->Right);}
              break;

            case CalcNode_Multiply:
              printf("NODE TYPE: %s\n", "CalcNode_Multiply");
              printf("NODE Value: %f\n", Node->Value);
              {Result = ExecCalcNode(Node->Left) * ExecCalcNode(Node->Right);}
              break;

            case CalcNode_Divide:
              printf("NODE TYPE: %s\n", "CalcNode_Divide");
              printf("NODE Value: %f\n", Node->Value);
              {/*TODO(casey): Guard 0*/Result = ExecCalcNode(Node->Left) / ExecCalcNode(Node->Right);}
              break;

            case CalcNode_Mod:
              printf("NODE TYPE: %s\n", "CalcNode_Mod");
              printf("NODE Value: %f\n", Node->Value);
              {/*TODO(casey): Guard 0*/Result = fmod(ExecCalcNode(Node->Left), ExecCalcNode(Node->Right));}
              break;

            case CalcNode_Constant:
              printf("NODE TYPE: %s\n", "CalcNode_Constant");
              printf("NODE Value: %f\n", Node->Value);
              {Result = Node->Value;}
              break;

            default:
              {Assert(!"AHHHHH!");}
        }
    }

    return(Result);
}

internal void
FreeCalcNode(calc_node *Node)
{
    if(Node)
    {
        FreeCalcNode(Node->Left);
        FreeCalcNode(Node->Right);
        free(Node);
    }
}







// PARSER LOGIC



#pragma warning(disable:4456)

internal calc_node *
ParseAddExpression(tokenizer *Tokenizer)
{
    calc_node *Result = 0;

    token Token = PeekToken(Tokenizer);
    printf("PARSE TOKEN: %s\n", Token.Text);
    printf("PARSE TOKEN TYPE: %u\n", Token.Type);
    if((Token.Type == Token_Minus) ||
       (Token.Type == Token_Number))
    {
        Result = ParseMultiplyExpression(Tokenizer);
        token Token = PeekToken(Tokenizer);
        if(Token.Type == Token_Plus)
        {
            GetToken(Tokenizer);
            Result = AddNode(CalcNode_Add, Result, ParseMultiplyExpression(Tokenizer));
        }
        else if(Token.Type == Token_Minus)
        {
            GetToken(Tokenizer);
            Result = AddNode(CalcNode_Subtract, Result, ParseMultiplyExpression(Tokenizer));
        }
    }

    return(Result);
}

internal calc_node *
ParseCalc(tokenizer *Tokenizer)
{

    calc_node *Node = ParseAddExpression(Tokenizer);

    return(Node);
}

// CUSTOM COMMAND

CUSTOM_COMMAND_SIG(casey_quick_calc)
{
    // the files we have access to edit only
    unsigned int access = AccessOpen;
    View_Summary view = get_active_view(app, access);

    Range range = get_view_range(&view);

    size_t Size = range.max - range.min;
    char *Stuff = (char *)malloc(Size + 1);
    Stuff[Size] = 0;

    Buffer_Summary buffer = get_buffer(app, view.buffer_id, access);
    buffer_read_range(app, &buffer, range.min, range.max, Stuff);

    // @note {} are called uniform initialization
    // @note this is the characters to read.  e.g. 4+4
    tokenizer Tokenizer = {Stuff};

    printf("PARSE TOKENS: %s\n", Tokenizer.At);
    // printf("RANGE MIN: %i\n", range.min);

    calc_node *CalcTree = ParseCalc(&Tokenizer);
    double ComputedValue = ExecCalcNode(CalcTree);
    FreeCalcNode(CalcTree);

    char ResultBuffer[256];
    int ResultSize = sprintf(ResultBuffer, "%f", ComputedValue);

    buffer_replace_range(app, &buffer, range.min, range.max, ResultBuffer, ResultSize);

    free(Stuff);
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
    // we actually need to re-call these
    set_all_default_hooks(context);

    // custom hooks here
    set_start_hook(context, custom_default_start);

#if defined(__APPLE__) && defined(__MACH__)
    mac_default_keys(context);
#else
    default_keys(context);
#endif

    // custom remapping of 4coder keys begins here
    begin_map(context, mapid_global);
    {
        // was previously `o`
        bind(context, 'p', MDFR_CMND, casey_quick_calc);
    }
    end_map(context);
    // END OF CUSTOM MAC KEY BINDING TEST

    int32_t result = end_bind_helper(context);
    return (result);
}
