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
