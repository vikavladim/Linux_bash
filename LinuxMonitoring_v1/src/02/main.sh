# function my_print {
str="HOSTNAME = $(hostname)
TIMEZONE =$(timedatectl | grep "Time zone" | awk '{$1=$2="";print$0}')
USER = $USER
OS = $(cat /etc/*-release | grep PRETTY_NAME | awk -F\" '{print$2}')
DATE = $(date '+%d %b %Y %T')
UPTIME =$(uptime -p | awk '{$1="";print$0}')
UPTIME_SEC = $(cat /proc/uptime | awk '{print$1}')
IP = $(ip a | grep inet | head -n1 | awk '{print$2}')
MASK = $(ip a | grep inet | tail -n1 | awk '{print$4}')
GATEWAY = $(ip route | grep default | awk '{print$3}')
RAM_TOTAL = $(printf "%.3f GB\n" $(free -t --mega | grep Total | awk '{print$2/1024}'))
RAM_USED = $(printf "%.3f GB\n" $(free -t --kilo | grep Total | awk '{print$3/1024}'))
RAM_FREE = $(printf "%.3f GB\n" $(free -t --kilo | grep Total | awk '{print$4/1024}'))
SPACE_ROOT = $(printf "%.2f MB\n" $(df | grep "/$" | awk '{print$2/1024}'))
SPACE_ROOT_USED = $(printf "%.2f MB\n" $(df | grep "/$" | awk '{print$3/1024}'))
SPACE_ROOT_FREE = $(printf "%.2f MB\n" $(df | grep "/$" | awk '{print$4/1024}'))"
# }


if [ $# -gt 0 ] 
then
echo "Здесь не нужны аргументы"
exit
fi

echo "$str"
read -p "Хотите записать данные в файл? (Y/N)" answer
if [[ $answer == Y || $answer == y ]]
then
name="$(date +"%d_%m_%y_%H_%M_%S").status"
echo "$str" > $name
fi