START=$(date +%s%N)
if [[ $# != 1 ]] 
then
echo "Укажите папку"
exit
elif [[ ! -d $1 ]] 
then
echo "Такой папки нет"
exit
elif  [[ ! $1 =~ [/]$ ]]
then
echo "Папка назначения должна заканчиваться символом /"
exit
fi

str="Total number of folders (including all nested ones) = $(find $1 -type d | wc -l)
TOP 5 folders of maximum size arranged in descending order (path and size):  
$(du -sh $1 | sort -rh | head -n 5 | cat -n |  awk '{print $1" - "$3", "$2;}')
Total number of files = $(find $1 -type f | wc -l)
Number of:  
Configuration files (with the .conf extension) = $(find $1 -type f -name "*.conf" | wc -l)
Text files = $(find $1 -type f -name "*.txt" -name "*.doc" -name "*.docx" -name "*.pdf" | wc -l) 
Executable files = $(find $1 -type f -executable | wc -l) 
Log files (with the extension .log) = $(find $1 -type f -name "*.log" | wc -l) 
Archive files = $(find $1 -type f -name "*.tar" -name "*.zip" -name "*.rar" | wc -l) 
Symbolic links = $(find $1 -type l | wc -l) 
TOP 10 files of maximum size arranged in descending order (path, size and type):  
$(find $1 -type f | xargs du -h | sort -rh | head -n 10 | cat -n | awk -F"." '{ORS=""; print$0" ";if($NF != 1)print$NF; print"\n"}' |  awk '{print $1" - "$3", "$2", "$4;}')
TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  
$(find $1 -type f -executable | xargs du -h | sort -rh | head -n 10 | cat -n | awk '{ORS=""; cmd="md5sum "$3" | awk \047{print$1}\047"; print $1" - "$3", "; while ( ( cmd | getline result ) > 0 ) {
        print result
    }
    close(cmd); 
    print"\n";
    }')"
echo "$str"
END=$(date +%s%N)
DIFF=$((( $END - $START )/1000000))
echo "Script execution time (in milliseconds) = $DIFF"
