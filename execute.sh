#!/bin/bash
ansible-playbook deploy.yml -t digitalocean,vpn,cloud \
  -e "do_access_token=$do_token do_server_name=york.shire do_region=$region"

config_files=`find configs/ -type f -regextype posix-extended -regex '.*/[0-9{1,}.[0-9]{1,}.[0-9]{1,}.[0-9]{1,}/.*'`

for filepath in $config_files; do
  filename=`basename $filepath`
  curl -X POST https://content.dropboxapi.com/2/files/upload \
  --header "Authorization: Bearer Ty5ds-yjdh4AAAAAAAA4kNU_x5rxwem96X-rqlTbK2wDiwY0y2fxzlLkAMUEFjvt" \
  --header "Dropbox-API-Arg: {\"path\": \"/$filepath\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
  --header "Content-Type: application/octet-stream" --data-binary @$filename
done

curl -X POST https://slack.com/api/chat.postMessage \
--data-ascii "token=$slack_token&channel=#bender_rodriguez&text=algo&username=papa"
