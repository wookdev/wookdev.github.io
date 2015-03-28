# pass 'id' in via the -v switch on the awk command line
#
/---/ && NR > 1 \
    {
        printf "mtid: %d\n", id
        printf "redirect_from:\n"
        printf "  - /saga/%d.html\n", id
    }
# print all lines
    { print $0 }

