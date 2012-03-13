spot(1) -- full-text bash search utility
===========================================

## Synopsis

   spot [-s|--sensitive] [-i|--insensitive]
        [-C|--no-colors] [-L|--no-linenums]
        [-h|--help] [directory] [term ...]

## Description

  By default unless `--sensitive` or `--insensitive` is
  specified __spot(1)__ implies `--sensitive` when an
  uppercased character is present in the search string.