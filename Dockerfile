FROM ubuntu:18.04 

RUN apt update -qq
RUN apt install -y -qq git apache2

RUN git clone --depth 1 https://github.com/ryuichiueda/bashcms2.git
