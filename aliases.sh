# search file contain specific content
s() {
    # search content recursively from path $2
    if [ "$#" -eq 2 ]; then
    grep -rnIi "$1" "$2"
    fi
    # search content recursively from current folder
    if [ "$#" -eq 1 ]; then
    grep -rnIi "$1" ./
fi
}

# search files that match the whole word
sw() {
    # search content recursively from path $2
    if [ "$#" -eq 2 ]; then
    grep -rnIiw "$1" "$2"
    fi
    # search content recursively from current folder
    if [ "$#" -eq 1 ]; then
    grep -rnIiw "$1" ./
fi
}

# search content in *.$2 type files
si() {
    echo "$2";
    # search content recursively from current path
    if [ "$#" -eq 2 ]; then
    grep --include=\*."$2"  -rnIi ./ -e "$1"
fi

}

# search file contain specific content, only display the file name
sf() {
    # search content recursively from path $2
    if [ "$#" -eq 2 ]; then
    grep -rnIil "$1" "$2"
    fi
    # search content recursively from current folder
    if [ "$#" -eq 1 ]; then
    grep -rnIil "$1" ./
    fi
}

# search files that match the whole word, only display the file name
sfw() {
    # search content recursively from path $2
    if [ "$#" -eq 2 ]; then
    grep -rnIilw "$1" "$2"
    fi
    # search content recursively from current folder
    if [ "$#" -eq 1 ]; then
    grep -rnIilw "$1" ./
    fi
}

# find files contains some string
f() { find . -name "$1" -print; }
