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
                esac
            ;;
        esac
    fi
} 

set_init_vars () { _

    var pwd $PWD -set_tail

    var git `which git` || exit 1

    var git_top_level_dir \
        `$git rev-parse --show-toplevel` \
        -check_if_dir_exists || exit 1 

    if [ $pwd != $git_top_level_dir ] ; then 
        em please enter git_top_level_dir $git_top_level_dir 
        em to see which files will be added to gitignore
        exit
    fi

    var gitignore \
        "$git_top_level_dir/.gitignore"
} 

add_files_to_git_ignore () { _ $@

    add_file_to_gitignore () { _ $@
        echo $1 >> $2
    } 

    #                            body                           #   

    cd $git_top_level_dir || exit 1
    
    for untracked_file in `git status | awk '
                                $1 == "Untracked" {
                                    getline
                                    getline
                                    while (getline > 0) {
                                        if (NF == 0) {
                                            exit   
                                        }       
                                        print
                                    } 
                                }
                                '` ; do
        add_file_to_gitignore \
            $untracked_file \
            $gitignore
    done

    cf $gitignore

    #                            end                            #   
} 
#                         #  body #                         #  

parse_args $@ 

set_init_vars 

add_files_to_git_ignore
#                         #  end #                         #  
