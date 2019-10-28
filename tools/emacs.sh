#!/bin/bash

apt-get install -y emacs

directory()
{
    DIRECTORY=~/.emacs.d/lisp/
    if [[ -d "$DIRECTORY" ]]; then
        echo -e "$DIRECTORY \e[32mexist\e[0m."
    else
        mkdir -p $DIRECTORY
    fi
    file
}

file() 
{
    DIRECTORY=~/.emacs.d/lisp/
    FILE=${DIRECTORY}std_comment.el
    if [[ -f "$FILE" ]]; then
        echo -e "$FILE \e[32mexist\e[0m."
    else
        wget https://raw.githubusercontent.com/etna-alternance/std_comment/master/std_comment.el -P $DIRECTORY
        echo "$FILE was \e[32mdownloaded\e[0m."
        echo ""
        echo "What is your ETNA login ?"
        read login
        cat $FILE | sed "22i\ (setq header-etna-login \"${login}\")" >> $FILE
        echo -e "(add-to-list 'load-path \"~/.emacs.d/lisp/\")\n(load-file \"~/.emacs.d/lisp/std_comment.el\")" > ~/.emacs
    fi
}

directory