" SPDX-License-Identifier: GPL-3.0-or-later
" Copyright (c) 2026 Aevom Contributors

" echo

    lac 017777 i                " load argc (unit: words)
    tad dm4
    dac argc
    lac 017777                  " load pointer to argc
    tad d5                      " advance pointer by 5 (skip argc and argv[0])
    dac argvptr

loop:
    lac argc
    sza
        jmp 1f
    jmp eolnexit                " print eoln and exit if no args


1:
    lac argvptr
    dac strptr
    jms puts
    sma
        jmp 2f
    jmp eolnexit                " print eoln and exit if write fails
2:
    lac argvptr
    tad d4                      " advance argv pointer by 4 (next argv)
    dac argvptr

    lac argc
    tad dm4                     " argc -= 4
    dac argc

    sza
        jms printws             " print whitespace if not the last arg
    jmp loop

eolnexit:
    lac d1
    sys write; eoln; 1
    jmp done

done:
    sys exit

puts: 0
    lac strptr
    tad d3                      " start checking from the end
    dac putsptr

    lac d4
    dac putsc

putsloop:
    lac putsptr i
    and charmsk
    sad space
        jmp chkhigh

    jmp putswrite               " not padded with space, print

chkhigh:
    lac putsptr i
    lrss 9
    and charmsk
    sad space
        jmp 1f

    dac putsptr i
    jmp putswrite               " high char not padded with space, print
1:
    lac putsptr
    tad dm1
    dac putsptr

    lac putsc
    tad dm1
    dac putsc

    sza
        jmp putsloop

    " all 4 words are spaces
    lac d0
    jmp puts i

putswrite:
    lac strptr
    dac writeptr
    lac d1
    sys write; writeptr: 0; putsc: 0
    jmp puts i

printws: 0
    lac d1
    sys write; space; 1
    spa
        jmp eolnexit            " print eoln and exit if write fails
    jmp printws i

d0: 0
d1: 1
d3: 3
d4: 4
d5: 5
dm1: -1
dm4: -4

argc: 0
argvptr: 0
strptr: 0
putsptr: 0
charmsk: 0177

eoln: 012
space: 040