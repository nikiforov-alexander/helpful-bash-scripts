#!/bin/bash
#                            initialization and helper 
filename=$0

# INCLUDE_BASH_SCRIPTS_PATH is variable that has to be set up
# as absolute path to where all bash scripts to be included
# will lie

if [ -z $INCLUDE_BASH_SCRIPTS_PATH ] ; then
    echo
    echo Please export INCLUDE_BASH_SCRIPTS_PATH
    echo with path to helpful bash scripts
    echo
    exit 1
fi

helpful_bash_funcs_include_script="$INCLUDE_BASH_SCRIPTS_PATH/helpful_bash_funcs.sh"

if [ -f $helpful_bash_funcs_include_script ] ; then
    source $helpful_bash_funcs_include_script
else
    echo
    echo helpful_bash_funcs_include_script $helpful_bash_funcs_include_script
    echo does not exist
    echo
    exit 1
fi

helper () { _
    em $filename
    em possible options are 
    em -h: "help"    - print this information and exit
    em -v: "vim"     - vim this script file
    em -n: "name"    - prints the name of script file
    em '[0]args': you will bew questioned about everything
    em '[n]args': '$1 ...'
}
#                            getopts 
while getopts  hvni: opt ; do
    case $opt in
        h) helper     && exit 0 ;;  
        v) ss_and_vim && exit 0 ;;
        n) echo $filename && exit 0 ;;
        i)
            em dummy argument $OPTARG 	
            exit 0
        ;;
        *)  em invalid option && exit 1 ;;  
    esac
    opts=1
done
#                            functions 
parse_args () { _
    if [ -z $opts ] ; then
        case $# in	
            0)
                em 0 args
            ;;
            *)
                case $1 in 
                    h) helper     && exit 0 ;;
                    v) ss_and_vim && exit 0 ;;
                    *)
                        em not implemented && exit 0
                    ;;
                esac
            ;;
        esac
    fi
} 

set_init_vars () { _
    var pwd $PWD -set_tail

    if [ -z MY_TRASH_DIR ] ; then
        var MY_TRASH_DIR="$HOME/.trash" \
            -check_if_dir_exists || exit 1 
    fi

    var day \
        `date | awk '
            {for(i=1;i<3;i++) printf("%s-",$i); printf("%s",$3)}
            '`
    var hour \
        `date | awk '{print $4}' | awk -F":" '{print $1}'`

    var time \
        `date | awk '{print $4}'`

    var dir_w_removed_file_in_trash \
        "$T/$day/$hour/${PWD:1:${#PWD}}/${time//:/-}"
        -crdir_if_not_exists || exit 1 
} 

#                         #  body #                         #  
set_init_vars 

parse_args $@ 

#                         #  end #                         #  
