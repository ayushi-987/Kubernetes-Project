FROM centos
LABEL maintainer="ayushisoni096@gmail.com"

RUN cd /etc/yum.repos.d/ \
    && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
    && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y install wget java httpd zip unzip \
    && yum clean all

RUN wget -O /var/www/html/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip \
    && unzip -q /var/www/html/photogenic.zip -d /var/www/html/ \
    && rm /var/www/html/photogenic.zip

WORKDIR /var/www/html/

RUN cp -rvf photogenic/* . \
    && rm -rf photogenic

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
