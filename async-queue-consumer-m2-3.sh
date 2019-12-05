#!/bin/bash
#Author: Nemanja Djuric
#Script to run all Magento 2 consumers in Screen and kill it after 50 seconds.

#!/bin/bash

if [[ -e app/etc/env.php ]]; then

i=0
input=$(php bin/magento queue:consumer:list)
 
echo "List of available consumers"
reset=$(php bin/magento queue:consumer:list)
echo ${reset}
 
while IFS= read -r line; do
    echo "starting $line each consumer in screen"
    $(screen -mdS screen$i php bin/magento queue:consumer:start $line)
    ((i++))
done <<< "$input"

sleep 50s && ps aux | grep consumer | awk {'print $2'} | xargs kill -s 9

else

echo "please cd into installation directory"

fi
