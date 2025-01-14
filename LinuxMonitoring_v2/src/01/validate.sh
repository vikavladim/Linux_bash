function validate() {
if [[ $count_var != 6 ]] 
then
echo "Требуется 6 аргументов: 
1) путь от корня, 
2) кол-во папок, 
3) список букв английского алфавита, используемый в названии папок,
4) кол-во файлов в подпапке,
5) список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения),
6) размер файлов (в килобайтах, но не более 100)"
exit
elif [[ ! -d $path ]] 
then
echo "Такой папки нет"
exit
elif  [[ ! $path =~ ^[/] ]]
then
echo "Папка назначения должна начинаться от корня"
exit
elif  [[ ! $count_dirs =~ ^[0-9]+$ ]]
then
echo "Кол-во папок не число"
exit
elif  [[ ! $letters_dirs =~ ^[a-zA-Z]{1,7}$ ]]
then
echo "Проверьте правила для шаблона папки"
exit
elif  [[ ! $count_files =~ ^[0-9]+$ ]]
then
echo "Количество файлов не число"
exit
elif  [[ ! $letters_files =~ ^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$ ]]
then
echo "Проверьте правила для шаблона файла"
exit
elif  [[ ! $size =~ ^[0-9]+$ ]] || [[ $size -gt 100 ]]
then
echo "Размер файлов должно быть числом не больше 100"
exit
fi
}