#!/bin/bash 


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

#                          functions
set_init_vars () { _

    var prog_name eclipse

    var prog_exec \
        $MY_BIN_DIR/$prog_name/java-ee/latest/$prog_name \
        -check_if_file_exists || exit 1 

    var prog_tmp_dir \
        "$MY_TMP_DIR/$prog_name" \
        -crdir_if_not_exists 

    var date \
        `date | sed "s/ /-/g" | sed "s/:/-/g"`

    var prog_log \
        "$prog_tmp_dir/$prog_name-$date.log"

} 

run_prog_in_background () { _ $@
   $1 &> $2 & 
} 

#                            body                           #   
set_init_vars

run_prog_in_background \
    $prog_exec \
    $prog_log

#                            end                            #   
