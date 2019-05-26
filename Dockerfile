FROM ubuntu:18.04 

RUN apt-get update -qq
RUN apt-get install -y -qq git apache2

RUN git clone --depth 1 https://github.com/ryuichiueda/bashcms2.git

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
