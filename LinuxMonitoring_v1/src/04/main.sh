column1_background=""
column1_font_color=""
column2_background=""
column2_font_color=""
trap "exit 1" TERM
export TOP_PID=$$

if [ $# -gt 0 ] 
then
echo "Здесь не нужны аргументы"
exit
fi

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

function set_color2() {
local output=""
if [[ $# -eq 2 ]]
then
output+=$1' ('
else
output+='default ('
fi

case $1 in
1) 
output+='white'
;;
2)
output+='red'
;;
3)
output+='green'
;;
4)
output+="blue"
;;
5)
output+="purple"
;;
6)
output+="black"
;;
*)
echo "Вводите числа от 1 до 6" >&2
kill -s TERM $TOP_PID
;;
esac
output+=")"
echo $output
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

column1_background_um=1
column1_font_color_um=2
column2_background_um=3
column2_font_color_um=4

source color.conf


if [[ $column1_background == "" ]]
then
column1_background=$column1_background_um
fi
if [[ $column1_font_color == "" ]]
then
column1_font_color=$column1_font_color_um
while [[ $column1_font_color -eq $column1_background ]]
do
column1_font_color=$(($RANDOM%6+1))
done
fi
if [[ $column2_background == "" ]]
then
column2_background=$column2_background_um
fi
if [[ $column2_font_color == "" ]]
then
column2_font_color=$column2_font_color_um
while [[ $column2_font_color -eq $column2_background ]]
do
column2_font_color=$(($RANDOM%6+1))
done
fi

str2="Column 1 background = "$(set_color2 $column1_background $column1_background_um)"
Column 1 font color = $(set_color2 $column1_font_color $column1_font_color_um)
Column 2 background = $(set_color2 $column2_background $column2_background_um)
Column 2 font color = $(set_color2 $column2_font_color $column2_font_color_um)"

if [[ $column1_background = $column1_font_color  ||  $column2_background = $column2_font_color ]]
then
echo "Цвета текста и фона не должны совпадать"
exit 0
fi

column1_background=$(set_color $column1_background)
column1_font_color=$(set_color $column1_font_color)
column2_background=$(set_color $column2_background)
column2_font_color=$(set_color $column2_font_color)

echo "$str"  | awk -F= '{print "\033[3"'$column1_font_color'"m""\033[4"'$column1_background'"m"$1" = \033[3"'$column2_font_color'"m""\033[4"'$column2_background'"m"$2"\033[0m";}'

echo -e "\n$str2"