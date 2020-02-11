#!/bin/sh

TOKEN="TELEGRAM TOKEN"
CHAT_ID="TELEGRAM BOT CHAT ID"

rm -r /home/joao.storrer/logs/rclone/*
rclone sync / backupRPi:Backups/RPi --exclude /dev/ --exclude /proc/ --exclude /sys/ --exclude /tmp/ --exclude /run/ --exclude /mnt/ --exclude /media/ --exclude /lost+found/ --exclude /usr/share/libreoffice/ --progress --log-file /home/joao.storrer/logs/rclone/rclone.log > /home/joao.storrer/logs/rclone/rcloneProgress.log

curl --silent -X POST --data-urlencode "chat_id=$CHAT_ID" --data-urlencode "text=$(tail -n 5 /home/joao.storrer/logs/rclone/rcloneProgress.log | tail --bytes=+62)" "https://api.telegram.org/bot$TOKEN/sendMessage"
