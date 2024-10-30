max=255-7

function print_n_letters() {
local letters=""
for (( i=0; i<$2; i++ )); do
letters+=$1
done
echo $letters
}

function create_name() {
local name=""
for (( i=0; i<${#1}; i++ )); do
local letter=${1:$i:1}
if [ $letter \= . ]
then
name+=$letter
else
local count=$((1 + $RANDOM % ($max-(${#1}-$i)-${#name})))
name+=$(print_n_letters $letter $count)
fi
done
while [ ${#name} -lt 4 ]
do
name+=$letter
done
echo $name
}

function my_touch() {
    for (( i=0; i<$2; i++ )); do
  filename="$(create_name $3)"_"$(date '+%d%m%y')"
  echo $filename
done
}