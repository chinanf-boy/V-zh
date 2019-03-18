cat './.html-list' | while read line || [[ -n ${line} ]]
do
    echo $line
    html2md -i $line -o "mds/${line##*/}.md"
done