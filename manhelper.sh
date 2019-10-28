#!/bin/bash

set -e


# Functions
print_help()
{
    echo "Usage: ./manhelper.sh [COMMAND] <OPTION> [FLAG NAME]"
    echo "OPTION:"
    echo -e "\t--usageflag [FLAG NAME] : Display information for the [FLAG NAME]"
    echo -e "\t--describe : Display description of the command"
}

checker()
{
    command=$1
    option=$2
    nb_param=$3

    if [ $nb_param -eq 0 ]; then
        print_help
        exit 0
    fi

    if ! which man &> /dev/null; then
        echo "ERROR: man is not installed"
        exit 1
    fi

    if echo $command | grep -q "\-"; then
        echo "ERROR: invalid synthax for command"
        print_help
        exit 1
    fi

    if [[ -n $option ]]; then
        echo "ERROR: unknown option"
        print_help
        exit 1
    fi
}

print_title()
{
    man $COMMAND | sed '/DESCRIPTION/q' | head -n -1
}

print_description()
{
    if [ $DESCRIBE == "YES" ]; then
        man $COMMAND | grep -A2 'DESCRIPTION'
    fi
}

print_flag()
{
    flag="$1"; flag=${flag#-}; flag=${flag#-}
    if [ $(man $COMMAND | awk '/^ *-'$flag' *.*$/,/^$/{print}' | head -n -1 | wc -l) != '0' ]; then
        man $COMMAND | awk '/^ *-'$flag' *.*$/,/^$/{print}'
    elif [ $(man $COMMAND | awk '/^ *--'$flag' *.*$/,/^$/{print}' | head -n -1 | wc -l) != '0' ]; then
        man $COMMAND | awk '/^ *--'$flag' *.*$/,/^$/{print}'
    else
        man $COMMAND | grep -e "[a-zA-Z][ ,]\-\-${flag}[,=\[\n]" -e "[ ,]\-\-${flag}$"
        echo
    fi
}

print_flags()
{
    if [ $FLAGS ]; then
        echo "FLAG"
        for FLAG_NAME in ${FLAGS//;/ } ; do
            print_flag $FLAG_NAME
        done
    fi
}


# Check input params and config
checker "$1" "" $#

# Init params
COMMAND="$1"
DESCRIBE="NO"
FLAGS=""
POSITIONAL=()

# Get params
while [[ $# -gt 0 ]]
do
key="$2"
case $key in
    --usageflag)
    FLAGS="${FLAGS};$3"
    shift
    shift
    ;;
    --describe)
    DESCRIBE=YES
    shift
    ;;
    *)
    POSITIONAL+=("$1")
    shift
    ;;
esac
done
set -- "${POSITIONAL[@]}"

# Check options
checker "$COMMAND" "$2" $#

# Print infos according to the params and options
print_title
print_description
print_flags
