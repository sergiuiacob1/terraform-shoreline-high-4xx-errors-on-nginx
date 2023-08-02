if [ $? -eq 0 ]; then

  systemctl restart nginx

  echo "NGINX restarted."

else

  echo "There was an error in the NGINX configuration file."

  exit 1

fi