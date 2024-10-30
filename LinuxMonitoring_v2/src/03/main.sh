. validate.sh
count_var=$#
letters_dirs=$1

validate

case $1 in
1) 
cat ../02/02.log | grep -iv duration | awk '{print$1}' | xargs rm -r 2> /dev/null;;
rm ../02/02.log 2> /dev/null
2) 
echo "Введите время начала, желательно, в формате YY-MM-DD HH:MM"
read dat1
echo "Введите время начала, желательно, в формате YY-MM-DD HH:MM"
read dat2
find / -newerct "$dat1" -not -newerct "$dat2" | xargs rm -r 2> /dev/null;;
3) #*az*_*
echo "Введите шаблон"
read template
find / -name $template | xargs rm -r 2> /dev/null;;
esac