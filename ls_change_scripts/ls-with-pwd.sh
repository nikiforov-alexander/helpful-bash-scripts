#/usr/users/nikiforo/scripts/d1-december
#                         #  initialization #                         #  
filename=$0
source $MY_SCRIPTS_DIR/include_bash_scripts/helpful_bash_funcs.sh
verbose_emf=0
VERBOSE=0
tput clear
helper () {
    filename_tail=`echo $filename | awk -F"/" '{print $NF}'`
    em helper of file $filename
    grep -B 1 "$filename_tail\"$" $aliases_scripts | head -1
    em '-h': 'help' print this info and exit
    em '-v': 'vim'  type ss and you can vim this file
}
#                         #  opts #                         #  
while getopts hvVl opt ; do
    case $opt in
        h) helper               && exit 0 ;;
        v) ss_and_vim           && exit 0 ;;
        V) VERBOSE=1                      ;;
        l) ls -l --color=always && exit 1 ;;
        *) em invalid option && exit 1 ;;
    esac
    opts=1
done
#                        #  deprecated stuff #                         #  
deprecated_stuff () {
    _  
    if [ $pprev == "s" ] ; then 
    echo -n -e "$pprev: `ls -pd $pprev* | grep -v "/" | awk 'BEGIN 	 {i=0;j=0;} \
                                     {l=l+length($1); \
                                  if (l>70 && i==0 && j==0) { i=1; printf("\n   ");}\
                                  else if (l>140 && i==1 && j==0) { i=0;j=1; printf("here 140\n   ");}\
                                  else if (l>210 && i==0 && j==1) { i=1;j=1; printf("\n   ");}\
                                  else if (l>280 && i==1 && j==1) { i=2;j=2; printf("\n   ");}\
                              else printf("%s ",$1);}' ` "
    fi
     
}
#                         #  functions #                         #  
parse_args () {
    _
    if [ -z $opts ] ; then 
        if [ $# -ne 0 ] ; then
            case $1 in
                h) helper     && exit 0 ;;
                v) ss_and_vim && exit 0 ;;
                V) verbose_emf=1  ;;
            esac
            ls $@ --color=always && exit 0
        fi
    fi
    
} 
    echo_cell_line_in_grey () {
        _
        gray
        echo "##############################################################"
        resetcolor
        
    } 
    echo_empty_line_and_cell_line_if_zero_args () {
        _
        if [ $# -gt 0 ] ; then
            echo
            echo_cell_line_in_grey
        fi
        
    } 
    echo_pwd_in_grey_color () {
        _
        tput setaf 0 && tput bold
        echo " $PWD"
        tput sgr0
        
    } 

print_PWD_and_show_label_after_listing_of_files () { #complex
    _  
    set_black_grey_color () { _
        tput setaf 9 && tput bold
    } 
    show_last_command () { 
        if [ `history | tail -10 | grep -c aa` -ge 1 ] ; then
            history | grep aa | tail -1 | awk '{print "last_command: ",$2}'
        else
            history | grep -v "]" | tail -1 | awk '{print "last_command: ",$2}'
        fi
    } 
    #                         #  body #                         #  
    echo_cell_line_in_grey
    set_black_grey_color

    #show_last_command
    echo $PWD

    set_black_grey_color
    echo_cell_line_in_grey
     
}
set_init_vars () {
    term_width=`tput cols`
    err=$MY_SCRIPTS_DIR/err
    touch $err
    if [ $term_width -le 90 ] ; then
        small_print_limit=10
        alphabetic_print_limit=20
    else
        small_print_limit=20
        alphabetic_print_limit=45
    fi
    
} 

check_for_Downloads_and_tanini_folders_they_ls_separately () {
    _
    case $PWD in
        /usr/users/nikiforo/Downloads|/fsnfs/users/nikiforo/liebe) ls --color=always -lrt && exit ;; 
    esac
    
} 
check_for_many_run0xxx_dirs_an_just_ls_if_the_exist () {
    _
    [ `ls | grep -c run` -gt 50 ] && ls --color=always && exit 0
    
} 
check_comment_file_and_set_comments () {
    _
    comment_file=.list-of-comments-for-each-dir-or-file
    if [ -f $comment_file ] ; then
        comments=1 
    else
        comments=0
    fi
    
} 
check_for_files_with_spaces () {
    _
    if [ `ls -1 | awk 'NF>1 {print}' | awk 'END {print NR}'` -gt 0 ] ; then
        em files with spaces
        ls -1 | awk 'NF>1' 
        em "###########################"
        #echo
    fi
    
} 

calculate_number_of_dirs () {
    _
    numdirs=` ls -p | grep -c "/" `
    let numdirs=$numdirs+1
    
} 
calculate_number_of_files () {
    _
    number_of_files=`ls | awk 'END {print NR}'`
    
} 

main_ls () {
    _  
    set_first_symbol_of_current_file () {
        _
        curr_first_symbol_of_the_curr_file=`echo ${file:0:1}`
        
    } 
    set_all_first_symbols_to_first_symbol_of_current_file () {
        _
                prev_first_symbol_of_the_prev_file=$curr_first_symbol_of_the_curr_file
        pprev_first_symbol_of_the_file_before_prev=$curr_first_symbol_of_the_curr_file
        
    } 
    set_initial_color () {
        _
        color=$i
        
    } 
    set_new_first_symbol_prev_and_before_prev () {
        _
        pprev_first_symbol_of_the_file_before_prev=$prev_first_symbol_of_the_prev_file
                prev_first_symbol_of_the_prev_file=$curr_first_symbol_of_the_curr_file
        
    } 
    change_the_color_if_first_symbol_is_not_equal_to_prev () {
        _
        let color=$color+1
        [ `echo ${#color}` -eq 2 ] && let color=${color:1:2}
        
    } 

    middle_print () {
        _  
        [ $file == "abba" ] && print_PWD_and_show_label_after_listing_of_files && exit 0
        size=`ls -lhd $file | awk '{printf("%4s",$5)}'`
        time=`ls -lhd $file | awk '{printf("%3s %2s",$6,$7)}'`
        tput setaf 0 && tput bold
        echo -n "$size $time	"
        tput setaf $color && tput bold
        echo -e "$file"
         
    }
    alphabetic_print () {
        _  
        print_all_dirs_containing_pprev_first_symbol () {
            _
            echo -n -e "$pprev_first_symbol_of_the_file_before_prev: \
                `ls -pd $pprev_first_symbol_of_the_file_before_prev* | grep "/" | awk 'NF==1 {printf("%s ",$1);}' ` " 
            echo
            
        } 
        print_all_files_containing_pprev_first_symbol () {
            _
            echo -n -e "$pprev_first_symbol_of_the_file_before_prev: \
                `ls -pd $pprev_first_symbol_of_the_file_before_prev* | grep -v "/" | awk 'NF==1 {printf("%s ",$1);}' ` " 

            echo $pprev_first_symbol_of_the_file_before_prev >> $err
            echo
            
        } 
        #                         #  body #                         #  
        tput setaf $color && tput bold
        if [ $curr_first_symbol_of_the_curr_file != $pprev_first_symbol_of_the_file_before_prev ] ; then
            if [ $i -gt $numdirs ] ; then	
                if [ `sed -n "/$pprev_first_symbol_of_the_file_before_prev/p" $err | awk 'END {print NR}'` -eq 0 ] ; then
                    print_all_files_containing_pprev_first_symbol
                fi
            else 
                print_all_dirs_containing_pprev_first_symbol 
            fi
            pprev_first_symbol_of_the_file_before_prev=$prev_first_symbol_of_the_prev_file
            [ $file == "abba" ] && print_PWD_and_show_label_after_listing_of_files && exit 0
        fi
         
    }
    small_print () {
        _  
        check_for_last_file_using_abba () {
            _
            [ $file == "abba" ] && print_PWD_and_show_label_after_listing_of_files && exit 0
            
        } 
        add_comments_small_print () {
            _
            if [ $comments -eq 1 ] ; then
                comment=`awk -v file=$file '
                    $1==file {print $2;comment_found=1} 
                    END { if(comment_found != 1) {print " "} }
                    ' $comment_file`
            fi
            
        } 
        get_size_and_time_from_ls () {
            _
            size=`ls -lhd $file | awk '{printf("%4s",$5)}'`
            time=`ls -lhd $file | awk '{printf("%3s %2s",$6,$7)}'`
            
        } 
        print_size_and_time_in_dark_grey () {
            _
            tput setaf 0 && tput bold
            echo -n "$size $time	"
            
        } 
        print_file_if_it_is_a_link () {
            _
            if [ -h $file ] ; then
                link=`ls -l $file | awk 'END {print $NF}'`
                tput setaf $color && tput bold
                echo -e "$file\t$comment $link\n" 
                return 1 # in order not to print twice
            fi
            
        } 
        set_small_print_color_to_zero_if_comments_E_or_to_usual_color () {
            _
            if [ ! -z $comment ] ; then
                case $comment in
                    R|_R) small_print_color=1 && tput blink     ;;
                    E|_E) small_print_color=5                   ;;
                    F|_F|*wrong*|*redo*|deprecated|old) small_print_color=0                   ;;
                       *) small_print_color=$color              ;; 
                esac
            else
                small_print_color=$color #color without comments
            fi
            
        } 
        final_echo_file_comment () {
            _
            tput setaf $small_print_color && tput bold 
            echo -e "$file\t$comment\n" 
            tput sgr0
            
        } 
        #                         #  body #                         #  
        check_for_last_file_using_abba
        add_comments_small_print
        get_size_and_time_from_ls
        print_size_and_time_in_dark_grey
        print_file_if_it_is_a_link || return 0
        set_small_print_color_to_zero_if_comments_E_or_to_usual_color
        final_echo_file_comment
         
    }
    #                         #  body #                         #  
    i=1
    for file in `ls -p --group -1 | awk 'NF==1 {print} END {print "abba"}'` ; do
        set_first_symbol_of_current_file
        if [ $i -eq 1 ] ; then
            set_all_first_symbols_to_first_symbol_of_current_file
            set_initial_color
        else
            if [ $curr_first_symbol_of_the_curr_file != $prev_first_symbol_of_the_prev_file ] ; then
                set_new_first_symbol_prev_and_before_prev
                change_the_color_if_first_symbol_is_not_equal_to_prev
            fi
        fi
        if   [ $number_of_files -lt $small_print_limit      ] ; then 
            small_print
        elif [ $number_of_files -gt $alphabetic_print_limit ] ; then	
            alphabetic_print
        else 		
            middle_print
        fi
        let i=$i+1
    done
     
}

list_files_using_usual_ls_if_number_of_files_is_greater_500 () {
    _
    [ $number_of_files -gt 500 ] &&  ls --color=always && exit 0
    
} 
unset_vars () {
    _
#   unset i
#   unset words
#   unset nf
#   unset j
#   unset prev
#   unset pprev
#   unset size
#   unset time
#   unset comment
#   unset comments
#   unset numdirs
    
} 
#                         #  body #                         #  
echo_cell_line_in_grey

parse_args $@

#print_PWD_and_show_label_after_listing_of_files

set_init_vars

check_for_Downloads_and_tanini_folders_they_ls_separately
check_for_many_run0xxx_dirs_an_just_ls_if_the_exist
check_comment_file_and_set_comments
check_for_files_with_spaces

calculate_number_of_files
calculate_number_of_dirs

list_files_using_usual_ls_if_number_of_files_is_greater_500

main_ls 

unset_vars

print_PWD_and_show_label_after_listing_of_files 
#                         #  end #                         #  
