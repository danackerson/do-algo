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
ADD execute.sh .
RUN chmod 700 execute.sh

ENTRYPOINT ["/algo-master/execute.sh"]
