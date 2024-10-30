if [ $# != 4 ]
then
echo "Введите 4 аргумента"
exit 1
elif [[ $1 = $2  ||  $3 = $4 ]]
then
echo "Цвета текста и фона не должны совпадать"
exit 0
fi

trap "exit 1" TERM
export TOP_PID=$$

function set_color() {
case $1 in
1) 
echo 7
;;
2)
echo 1
;;
3)
echo 2
;;
4)
echo 4
;;
5)
echo 5
;;
6)
echo 0
;;
*)
echo "Вводите числа от 1 до 6" >&2
kill -s TERM $TOP_PID
;;
esac
}


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

column1_background=$(set_color $1)
column1_font_color=$(set_color $2)
column2_background=$(set_color $3)
column2_font_color=$(set_color $4)
echo "$str"  | awk -F= '{print "\033[3"'$column1_font_color'"m""\033[4"'$column1_background'"m"$1" = \033[3"'$column2_font_color'"m""\033[4"'$column2_background'"m"$2"\033[0m";}'