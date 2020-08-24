FROM php:7.1-apache

ENV DISCUZ_PACKAGE      "/var/discuz"
ENV DISCUZ_INSTALL      "/var/www/html"
ENV DISCUZ_DATA         "/var/www/html/data"
ENV DISCUZ_CONFIG       "/var/www/html/config"
ENV DISCUZ_UC_CLIENT    "/var/www/html/uc_client"
ENV DISCUZ_UC_SERVER    "/var/www/html/uc_server"
ENV DISCUZ_PACKAGE_NAME "DISCUZ-X3.4-R20200818-SC-UTF8.zip"


RUN apt-get update && apt-get install -y unzip libjpeg-dev libfreetype6-dev libwebp-dev libpng-dev\
	&& docker-php-ext-install gd pdo_mysql mysqli\
	&& mkdir -p "${DISCUZ_PACKAGE}"\
	&& chmod -R 700 "${DISCUZ_PACKAGE}"

COPY "discuz-install.sh" "${DISCUZ_PACKAGE}"
COPY "${DISCUZ_PACKAGE_NAME}" "${DISCUZ_PACKAGE}"

RUN chmod +x "${DISCUZ_PACKAGE}/discuz-install.sh"

ENTRYPOINT ["/var/discuz/discuz-install.sh"]

CMD ["apache2-foreground"]
