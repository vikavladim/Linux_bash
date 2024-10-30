. validate.sh
. create_names.sh
# START=$(date +%s%N)
date=$(date '+%d%m%y')

count_var=$#
path=$1
count_dirs=$2
letters_dirs=$3
count_files=$4
letters_files=$5
size=$6

validate
if  [[ ! $path =~ [/]$ ]]
then
path=$path/
fi

for (( i=0; i<$count_dirs; i++ )); do
    foldername="$(create_name $letters_dirs)"_"$date"
    if [ -d $path$foldername ]; then
        i=$i-1
    else
    mkdir $path$foldername
    echo "$path$foldername $date" >> 01.log
    for (( j=0; j<$count_files; j++ )); do
        filename="$(create_name $letters_files)"_"$date"
        filename="$path$foldername/$filename"
        if [ -f  $filename ]; then
            j=$j-1
        else
            fallocate -l $size"KB" $filename
            echo "$filename $date $(du -h $filename | awk '{print$1}')" >> 01.log
            if [[ $(df --output=avail / | grep -iv ava) -lt 1024*1024 ]]
                then
                echo "Осталось меньше 1 ГБ"
                exit
            fi
        fi
    done
    fi
done
