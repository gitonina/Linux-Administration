n=${1:-20}
ciclo=("tulio" "lulo" "lana" "tarro" "patana")
indice=0
contador=0

while [ $contador -le  $n ] && read -r carta || [[ -n $carta ]]   ; do
    contador=$((contador + 1))
    carta_esperada="${ciclo[$indice]}" 
    if [ "$carta" = "$carta_esperada" ]; then
        echo "$carta"
        indice=0  
    elif [ "$carta" = "juanin" ]; then
        echo "estamos al aire"
        indice=0  
    elif [ "$carta" = "bodoque" ]; then
        printf "\U1F430\n"  
        indice=0
    elif [ "$carta" = "tramoya" ]; then
        printf "\U1F528 \U1F528 \U1F528\n" 
        indice=0 
    else
    
        indice=$(((indice + 1) % 5))
    fi
done 

