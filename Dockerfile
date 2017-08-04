FROM ubuntu

RUN apt-get update && apt-get install \
build-essential \
openssh-server \
wget \
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

ENTRYPOINT ansible-playbook deploy.yml -t digitalocean,vpn,cloud -e "do_access_token=$do_token do_server_name=york.shire do_region=$region"
