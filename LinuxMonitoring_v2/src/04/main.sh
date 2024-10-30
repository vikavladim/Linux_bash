. fun.sh

count=$((100 + $RANDOM % 900))
date="$((2000+$RANDOM % 23))-$((1+$RANDOM % 12))-$((1+$RANDOM % 28)) 00:00:00"
date_sec=$(date -d "$date" '+%s')
let frequency=24*60*60/count

if [[ $# != 0 ]] 
then
echo "Здесь не требуются аргументы"
exit
fi

for (( i=0; i<count; i++ )); do
    # date=$(date -d @"$date_sec" '+%F %T')
    # date=$(date -d @"$date_sec" '+%02e/%03b/%Y:%T %z')
    # date=$(date -d @"$date_sec" '+%d/%b/%Y:%T %z')
    date=$(date -d @"$date_sec" '+%d/%b/%Y:%T ')
    # echo "$(get_ip), $(get_cod), $(get_method), "$date", $(get_URL), $(get_agent);" >> 04.log
    echo "$(get_ip) [$date] \"$(get_method) $(get_URL)\" $(get_cod) - \"$(get_agent)\"" >> 04.log
    let date_sec+=frequency
done
