
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High 4xx Errors on NGINX
---

This incident type is related to a high number of 4xx errors on NGINX upstreams. This error is higher than usual and requires investigation to identify the root cause. The incident description typically includes details on the percentage of anomalous errors, the query used to detect the errors, and other relevant information such as the event type, monitor state, and tags. The incident may require the attention of the software engineer or other relevant personnel to resolve the issue and prevent it from reoccurring in the future.

### Parameters
```shell
# Environment Variables

export ERROR_MESSAGE="PLACEHOLDER"

export SETTING_NAME="PLACEHOLDER"

export IP_ADDRESS="PLACEHOLDER"

export UPSTREAM_SERVER_URL="PLACEHOLDER"

export PATH_TO_NGINX_CONF_FILE="PLACEHOLDER"
```

## Debug

### Check the status of the NGINX service
```shell
systemctl status nginx.service
```

### Check the NGINX error log for any relevant error messages
```shell
tail -n 100 /var/log/nginx/error.log | grep "${ERROR_MESSAGE}"
```

### View NGINX access logs to identify the sources of the 4xx errors
```shell
tail -n 100 /var/log/nginx/access.log | grep " 4[0-9][0-9] "
```

### Check the configuration file for any syntax errors
```shell
nginx -t
```

### Check the NGINX configuration file for any relevant settings
```shell
cat /etc/nginx/nginx.conf | grep "${SETTING_NAME}"
```

### Check the system load and resource usage
```shell
top
```

### Check network connectivity between NGINX upstreams and clients/servers
```shell
ping ${IP_ADDRESS}
```

### Check NGINX upstream servers for any issues
```shell
curl -I ${UPSTREAM_SERVER_URL}
```

## Repair

### Define the path to the NGINX configuration file
```shell
NGINX_CONF="${PATH_TO_NGINX_CONF_FILE}"
```

### Check if the configuration file exists
```shell
if [ ! -f "$NGINX_CONF" ]; then

  echo "The NGINX configuration file does not exist."

  exit 1

fi
```

### Check the configuration file for any syntax errors
```shell
nginx -t -c "$NGINX_CONF"
```

### Restart NGINX if the configuration file is valid
```shell
if [ $? -eq 0 ]; then

  systemctl restart nginx

  echo "NGINX restarted."

else

  echo "There was an error in the NGINX configuration file."

  exit 1

fi
```