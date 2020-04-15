#! /usr/bin/env bash

LANG=${1:-cpp}

./custom/bin/build_one_time.sh ./custom/languages/${LANG}/lexer_gen.cpp
./one_time
rm ./one_time
