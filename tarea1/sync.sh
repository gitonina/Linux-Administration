#!/bin/bash
inicio=$1
termino=$2
source .env


for year in $(seq $inicio $termino); do
    for month in $(seq -w 1 12); do
        
        start_date="$year-$month-01"
        end_date=$(date -d "$start_date +1 month -1 day" +%Y-%m-%d)

        
        url="$APP_PROTOCOL://$APP_HOST:$APP_PORT/api/sync_push?startDate=$start_date&endDate=$end_date"

    
        for intento in $(seq 1 $APP_MAX_RETRIES); do
            response=$(curl -s -o /dev/null -w "%{http_code}" \
                       -H "x-api-key: $APP_API_KEY" "$url")

            if [ "$response" -eq 200 ]; then
                echo " Éxito: $year-$month (intento $intento)"
                break
            else
                echo " Intento $intento fallado para $year-$month"
                if [ $intento -lt $APP_MAX_RETRIES ]; then
                    sleep 1  
                fi
            fi
        done

  
        if [ "$response" -ne 200 ]; then
            error_msg="$(date) - Error en $year-$month después de $APP_MAX_RETRIES intentos"
            echo "$error_msg" >> error.log
            echo " $error_msg"
        fi

      
        sleep $APP_WAIT_SECONDS
    done
done


