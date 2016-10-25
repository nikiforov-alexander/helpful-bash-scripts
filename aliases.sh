
_ () { # function that echoes the function name starts or ends

    #declare | vim -
    error_of_echo_function="ERROR in _ echo_function:"
    #
    #                            set indent_of_echo_function using default value of 4 spaces
    #
    default_number_of_indentation_spaces="4"
        #declare | grep 'FUNCNAME=' | grep -v declare # DEBUG 
    indent_of_echo_function=`echo ${#FUNCNAME[@]} | awk \
        -v default_number_of_indentation_spaces="$default_number_of_indentation_spaces" '
        { print ($1-2)*default_number_of_indentation_spaces}
        '`
    let INDENT=$indent_of_echo_function+$default_number_of_indentation_spaces
    [ $indent_of_echo_function -le 0 ] && echo $error_of_echo_function wrong_indent $indent_of_echo_function && return 1
    string_equal_to_number_of_spaces_to_indent=`echo $indent_of_echo_function | awk '
        { for(i=1;i<=$1;i++) printf(" ") } 
        '`
        #echo "number_of_spaces is ${#string_equal_to_number_of_spaces_to_indent}" # DEBUG
    #                            
    #                            set func_name_to_echo depending on verbosity and checking whether we are in function indeed and not in body 
    #                            
    [ -z ${FUNCNAME[1]} ] && echo $error_of_echo_function use in script only && return 1
    if [ -z $verbose_emf ] ; then
        func_name_to_echo=${FUNCNAME[1]}
    else
        if [ $verbose_emf == "1" ] ; then
            func_name_to_echo="${FUNCNAME[1]}"
            for ((number_of_function=2;number_of_function<${#FUNCNAME[@]}-1;number_of_function++)) ; do
                func_name_to_echo+=" :: ${FUNCNAME[$number_of_function]}"
            done
        else
            func_name_to_echo=${FUNCNAME[1]}
        fi
    fi
    tput setaf 8 && tput bold
    echo "${string_equal_to_number_of_spaces_to_indent}$func_name_to_echo : $@" 
    tput sgr0
} 

set_alias () { _ $@
    alias_name=$1
    shift
    eval "alias $alias_name='$@'" 
    alias $alias_name
} 

#                            body                           #   
set_alias v vim
set_alias vc 'vim ~/.bashrc'

set_alias ssh-server 'ssh nikiforo@ssh.mpi-muelheim.mpg.de'

set_alias ']' 'ls -xGhop'
set_alias ']]' 'ls -xGhotrp'

set_alias '.' 'cd ..'
set_alias ".." "cd .."

set_alias md 'mkdir -v'

set_alias rmf '/bin/rm -f'

set_alias sc "source ~/.bashrc"
set_alias sa "source ~/.bash_aliases"

set_alias gs 'git status'

set_alias chrome '/opt/google/chrome/google-chrome'

set_alias cx 'chmod +x'
#popd these will be defined manually
alias --  -="popd +0"
alias -- -1="popd +1"
alias -- -2="popd +2"
alias -- -3="popd +3"
alias -- -4="popd +4"
alias -- -5="popd +5"
#                            end                            #   
