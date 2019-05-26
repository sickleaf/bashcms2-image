FROM ubuntu:18.04 

RUN apt-get update -qq
RUN apt-get install -y -qq git apache2 rsync sudo pandoc gawk

RUN a2enmod cgid
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD bashcms2_http.conf /etc/apache2/sites-enabled/bashcms2_http.conf

RUN git clone -b bootstrap --depth 1 https://github.com/ryuichiueda/bashcms2.git
RUN USER=root /bashcms2/deploy

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
