#!/bin/bash

while true
do

#TROQUE
#TROQUE
  HORA_CERTA='0000'
  HORA=$(date +%H%M) # captura a hora

  if [ "${PANEL}" = "Jexactyl" ] || [ "${PANEL}" = "Jexactyl Brasil" ]; then
     if [ "$HORA" == "$HORA_CERTA" ]; then
       php /home/container/panel/artisan p:schedule:renewal >> /dev/null 2>&1
     fi
  fi

    if [ "$HORA" == "$HORA_CERTA" ]; then
      cp panel/.env backups/.env-$(date +%F-%Hh%Mm)
      find ./backups/ -mindepth 1 -not -name "executed" -mtime +7 -delete # executa o script desejado
    fi

  php /home/container/panel/artisan schedule:run >> /dev/null 2>&1 && /bin/bash /crontab_test.sh

  sleep 60
done
