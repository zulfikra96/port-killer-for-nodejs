output=$(netstat -nlp | grep :$1)

IFS=' ' 
read -ra ADDR <<< "$output"
ITER=0
for i in "${ADDR[@]}";
do # access each element of array
    if [ "$i" == "LISTEN" ]; then
        # echo "${ADDR[$(expr $ITER + 1)]}"
        IFS='/'
        KILLER=${ADDR[$(expr $ITER + 1)]}
        read -ra KILLER_ADDR <<< "$KILLER"
        kill -9 ${KILLER_ADDR[0]}    
        # echo "$i"
    fi
    ITER=$(expr $ITER + 1)
done

nodemon index.js