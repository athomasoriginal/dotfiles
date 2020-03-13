// https://gist.github.com/arrieta/1a309138689e09375b90b3b1aa768e20
// lexer
//
// \0 - null termination character.  let's us know when we reached end of string

#include <string>

enum token_type
{
    Token_Comment,
};

struct token
{
    token_type Type;
    int32_t EndCursor;
};

struct tokenizer
{
    // @TODO maybe rename this to cursor for my own sanity?
    char *At;
};

bool is_space(char c) noexcept {
    switch(c) {
        case ' ':
        case '\t':
        case '\r':
        case '\n':
        return true;
        default:
        return false;
    }
}

int main() {
    std:string text = "; this is a comment";

    int32_t cursor = 0;
    tokenizer Tokenizer = {text};

    while(cursor < code.size()) {

      switch(Tokenizer.At[cursor]) {

        case ';': {
          fprintf(stdout, "%s\n", "Found a comment");
          int32_t nextCursor = cursor;

          while (Tokenizer.At[nextCursor] != '\0') {
            ++nextCursor;

            if (Tokenizer.At[tick] == '\n') {
              fprintf(stdout, "%s\n", "Found a newline");
              continue;
            }

            continue;
          }

          break;
        }
        default: {
          fprintf(stdout, "%s\n", "Landed in default");
          break;
        }
      }
    }

    return 0;
}



// int main() {
//     std:string code = "Hello There are 4 spaces";
//
//     for (int i = 0; i<code.size(); i++ ) {
//         std::cout << is_space(code[i]);
//     }
//
//     return 0;
// }


//     case '"': {
//       int32_t tick = i;
//       ++tick; // or else we get stuck on the one we were just on
//       while(is_not_closing_doublequote(Tokenizer.At[tick])) {
//         ++tick;
//       }
//
//       ++tick; // or else we get stuck on the one before the last
//
//       int32_t finaltick = tick - i;
//       Highlight_Record *record = push_array(scratch, Highlight_Record, 1);
//       record->first = i + on_screen_range.first; // the letter to start the color on
//       record->one_past_last = record->first + finaltick; // the letter to end the color on
//       record->color = 0xFFFF0000; // green
//       tail.str += finaltick;
//       tail.size -= finaltick;
//       i += finaltick;
//
//       break;
//     }
//     case 'a':
//     case 'b':
//     case 'c':
//     case 'd':
//     case 'e':
//     case 'f':
//     case 'g':
//     case 'h':
//     case 'i':
//     case 'j':
//     case 'k':
//     case 'l':
//     case 'm':
//     case 'n':
//     case 'o':
//     case 'p':
//     case 'q':
//     case 'r':
//     case 's':
//     case 't':
//     case 'u':
//     case 'v':
//     case 'w':
//     case 'x':
//     case 'y':
//     case 'z':
//     case 'A':
//     case 'B':
//     case 'C':
//     case 'D':
//     case 'E':
//     case 'F':
//     case 'G':
//     case 'H':
//     case 'I':
//     case 'J':
//     case 'K':
//     case 'L':
//     case 'M':
//     case 'N':
//     case 'O':
//     case 'P':
//     case 'Q':
//     case 'R':
//     case 'S':
//     case 'T':
//     case 'U':
//     case 'V':
//     case 'W':
//     case 'X':
//     case 'Y':
//     case 'Z': {
//       Highlight_Record *record = push_array(scratch, Highlight_Record, 1);
//       record->first = i + on_screen_range.first;
//       record->one_past_last = record->first + 1;
//       record->color = 0xFF0044FF; // light gray
//       break;
//     }
//     default:
//     {} break;
