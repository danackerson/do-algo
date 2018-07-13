FROM ubuntu

ARG TOKEN

RUN apt-get update && apt-get install \
build-essential \
openssh-server \
wget \
curl \
unzip \
vim \
libssl-dev \
libffi-dev \
python-dev \
python-pip \
python-setuptools \
python-virtualenv -y

RUN wget -O algo-master.zip https://codeload.github.com/trailofbits/algo/zip/master && unzip algo-master.zip

WORKDIR /algo-master
RUN python -m pip install -U pip && python -m pip install -r requirements.txt

# on success, upload ALL files from /algo-master/configs
ENTRYPOINT ansible-playbook deploy.yml -t digitalocean,vpn,cloud \
  -e "do_access_token=$do_token do_server_name=york.shire do_region=$region" \
  && for filepath in `find /algo-master/configs -name '*' -type f`;do filename=`basename $filepath`;curl -F "fileupload=@$filepath" "https://ackerson.de/up/$filename?tok=$TOKEN";done \
  && echo `curl -s https://slack.com/api/chat.postMessage -X POST -d "token=$slack_token&channel=#bender_rodriguez&text=algo&username=papa"`
