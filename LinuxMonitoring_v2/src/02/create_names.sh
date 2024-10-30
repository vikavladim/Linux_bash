max=255-7

function print_n_letters() {
local letters=""
for (( i=0; i<$2; i++ )); do
letters+=$1
done
echo $letters
}

