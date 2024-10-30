. validate.sh
count_var=$#
letters_dirs=$1

validate

case $1 in
1) 
cat ../04/04.log | sort -k6 ;;
# cat ../04/04.log | gawk -F, '
# {
#     arr[$1]=$0;
# }
# END {
#     PROCINFO["sorted_in"] = "@ind_num_asc"
#     for(f in arr) printf arr[i]
# }
# ' ;;
    # amap[arr[k]]=k
    # asort(arr,asorted,"@val_num_desc")
    # for(i=1; i<=length(asorted);++i)
    #     print amap[asorted[i]], asorted[i]
2) 
cat ../04/04.log | awk '
    {
        if (!($1 in a)) 
            a[$1]=$0;
    } 
    END {
        for (i in a) 
            print a[i]
    }' ;;
3) 
cat ../04/04.log | awk '
    {
        if($6>=400) 
            print$0;
    }' ;;
4) cat ../04/04.log | awk '
    {
        if($6>=400) 
            a[$1]=$0
    } 
    END {
        if (!($1 in a)) 
            a[$1]=$0;
    } 
    END {
        for (i in a) 
        print a[i]
    }' ;;
esac