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

RUN wget -O algo-master.zip https://codeload.github.com/trailofbits/algo/zip/master && unzip algo-master.zip

WORKDIR /algo-master
RUN python -m pip install -U pip && python -m pip install -r requirements.txt

ENTRYPOINT sudo ansible-playbook main.yml -t vpn,cloud -e "provider=digitalocean do_token=$do_token server_name=york.shire region=$region" && echo `curl -s https://slack.com/api/chat.postMessage -X POST -d "token=$slack_token&channel=#bender_rodriguez&text=algo&username=papa"`
