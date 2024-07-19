counter=0
while true; do
    for i in {1..150}
    do
        open -a RuneLite && sleep 1
        # automator -v osrs/cheap_ha.workflow >> /dev/null
        # automator -v osrs/string_bow.workflow >> /dev/null && sleep 20
        # automator -v ./bow.workflow >> /dev/null && sleep 47
        # automator -v ./cook.workflow >> /dev/null && sleep 64
        automator -v ./fire.workflow >> /dev/null && sleep 64
        printf "\r%d" $i
        counter=$((counter+1))
        if [ $counter -eq 280 ]; then
            exit 0
        fi
    done

    echo "\nlogging out and logging in...\n"
    automator ./logout_login_fletching.workflow >> /dev/null
done
