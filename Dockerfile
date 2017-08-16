FROM ubuntu

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

RUN wget https://github.com/trailofbits/algo/archive/master.zip && unzip master.zip

WORKDIR /algo-master
RUN python -m pip install -U pip && python -m pip install -r requirements.txt

#ENTRYPOINT ansible-playbook deploy.yml -t digitalocean,vpn,cloud -e "do_access_token=$do_token do_server_name=york.shire do_region=$region" && curl https://slack.com/api/chat.postMessage -X POST -d 'token=$slack_token&channel=#remote_network_report&text=algo&username=papa'
ENTRYPOINT ansible-playbook --help && echo $? && echo `curl -s https://slack.com/api/chat.postMessage -X POST -d 'token=${slack_token}&channel=#remote_network_report&text=algo&username=papa'`
