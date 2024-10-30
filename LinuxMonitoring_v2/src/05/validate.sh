function validate() {
if [[ $count_var != 1 ]] 
then
echo "Требуется 1 аргумент: 
1. Все записи, отсортированные по коду ответа
2. Все уникальные IP, встречающиеся в записях
3. Все запросы с ошибками (код ответа - 4хх или 5хх)
4. Все уникальные IP, которые встречаются среди ошибочных запросов"
exit
elif  [[ ! $letters_dirs =~ ^[1-4]$ ]]
then
echo "Выберите пункт меню 1-4"
exit
fi
}