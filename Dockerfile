FROM ubuntu:20.04 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq
RUN apt-get install -y -qq git apache2 curl rsync sudo pandoc gawk nkf vim make

## General
#FROM base AS general-builder
#RUN target=/var/lib/apt/lists,source=/var/lib/apt/lists

WORKDIR /downloads

# Open-usp-Tukubai
RUN git clone --depth 1 https://github.com/usp-engineers-community/Open-usp-Tukubai.git
# teip
RUN curl -sfSL --retry 5 https://git.io/teip-1.2.1.x86_64.deb -o teip.deb
# Python
RUN apt-get install -y -qq python3-dev python3-pip python3-setuptools
RUN target=/root/.cache/pip \
    pip3 install --progress-bar=off --no-use-pep517 asciinema faker matplotlib numpy pillow scipy sympy xonsh yq


# Open-usp-Tukubai
RUN target=/downloads,source=/downloads cd /downloads/Open-usp-Tukubai && make install
# teip
RUN target=/downloads,source=/downloads dpkg -i /downloads/teip.deb
# Python
RUN ln -s /usr/bin/python3 /usr/bin/python


WORKDIR /

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
