. validate.sh
. create_names.sh
START=$(date '+%T')
START_dop=$(date '+%s')
date=$(date '+%d%m%y')

count_var=$#
letters_dirs=$1
letters_files=$2
size=$3

count_files=$(df --output=avail / | grep -iv ava)/50*2
max=255-7

validate

function def_mas_dirs() {
 for (( i=0; i<${#1}; i++ )); do
 masd[$i]=1
 done
}

function def_mas_files() {
 for (( i=0; i<${#1}; i++ )); do
 masf[$i]=1
 done
}
 
function add_mas_d() {
    masd[${#1}-1]=${masd[${#1}-1]}+1
    for (( i=${#1}-1; i >= 0; i-- )); do
 local sum=0
 for (( z=0; z < ${#1}; z++ )); do
 let sum+=${masd[$z]}
 done
 if [[ $sum -gt $max ]]
 then
    masd[$i]=1
  masd[$i-1]=${masd[$i-1]}+1
 fi
 done
}

function add_mas_f() {
    masf[${#1}-1]=${masf[${#1}-1]}+1
 for (( i=${#1}-1; i >= 0; i-- )); do
 local sum=0
 for (( z=0; z<${#1}; z++ )); do
 let sum+=${masf[$z]}
 done
 if [[ $sum -gt $max ]]
 then
 masf[$i]=1
  masf[$i-1]=${masf[$i-1]}+1
 fi
 done
}

function create_named() {
    local name=""
    for (( i=0; i<${#1}; i++ )); do
    local letter=${1:$i:1}
    if [ $letter \= . ]
    then
    name+=$letter
    else
    name+=$(print_n_letters $letter ${masd[$i]})
    fi
    done
    while [ ${#name} -lt 5 ]
    do
    name+=$letter
    add_mas_d $1
    done
    echo $name
}

function create_namef() {
    local name=""
    for (( i=0; i<${#1}; i++ )); do
    local letter=${1:$i:1}
    if [[ $letter = . ]]
    then
    name+=$letter
    else
    name+=$(print_n_letters $letter ${masf[$i]})
    fi
    done
    while [ ${#name} -lt 5 ]
    do
    name+=$letter
    add_mas_f $1
    done
    echo $name
}

def_mas_dirs $letters_dirs

find / -type d 2> /dev/null | grep -iv bin > temp.log
max_folder="$(wc -l temp.log| awk '{print$1}')"

while :
do
    foldername="$(create_named $letters_dirs)"_"$date"
    add_mas_d $letters_dirs
    path="$(cat temp.log | head -n $((1 + $RANDOM % $max_folder)) | tail -1)"
    # path="$(pwd)"
    path+=/
    mkdir $path$foldername 2> /dev/null
    echo "$path$foldername $date" >> 02.log
    count_files=$((1 + $RANDOM % $count_files))
    def_mas_files $letters_files
    for (( j=0; j<$count_files; j++ )); do
        filename="$(create_namef $letters_files)"_"$date"
        add_mas_f $letters_files
        filename="$path$foldername/$filename"
        fallocate -l $size"MB" $filename 2> /dev/null
        echo "$filename $date $(du -h $filename 2> /dev/null | awk '{print$1}')" >> 02.log
        if [[ $(df --output=avail / | grep -iv ava) -lt 1024*1024 ]]
            then
            echo "Осталось меньше 1 ГБ"
            exit
        fi
    done
done

rm -rf temp.log
END=$(date '+%T')
END_dop=$(date '+%s')
let duration=$END_dop-$START_dop
echo "start $START end $END duration $duration)" >> 02.log
echo "start $START end $END duration $duration"