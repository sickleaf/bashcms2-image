FROM ubuntu:18.04 

RUN apt update -qq
RUN apt install -y -qq git

RUN git clone --depth 1 https://github.com/ryuichiueda/bashcms2.git
