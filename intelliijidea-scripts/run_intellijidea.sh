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

    var idea_exec \
        $MY_BIN_DIR/intellijidea/latest/bin/idea.sh \
        -check_if_file_exists || exit 1 

    var idea_tmp_dir \
        "$MY_TMP_DIR/idea" \
        -crdir_if_not_exists 

    var idea_log \
        "$idea_tmp_dir/idea-$date.log"

    var date \
        `date | sed "s/ /-/g" | sed "s/:/-/g"`
} 

run_idea_in_background () { _ $@
   $1 &> $2 & 
} 
#                            body                           #   

set_init_vars

run_idea_in_background \
    $idea_exec \
    $idea_log

#                            end                            #   
