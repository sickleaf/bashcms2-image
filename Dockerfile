FROM ubuntu:20.04 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq
RUN apt-get install -y -qq git apache2 rsync sudo pandoc gawk nkf vim

RUN a2enmod cgid
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD bashcms2_http.conf /etc/apache2/sites-enabled/bashcms2_http.conf

ENV LANG ja_JP.UTF-8

ARG pass
RUN git clone https://wklov:$pass@github.com/wklov/bashcms2/
RUN USER=root /bashcms2/deploy "clean" "$pass"

RUN touch /var/www/bashcms2_sample_data/INIT
RUN USER=www-data /var/www/system_bashcms2/fetch*

EXPOSE 8070
CMD ["apachectl", "-D", "FOREGROUND"]
