FROM craftolutionhub/magento2.1.x-nginx-base

COPY ./app/* /var/www/html/app/
COPY ./bin/* /var/www/html/bin/
COPY ./pub/media/* /var/www/html/pub/media/
COPY ./dev/tests/unit/phpunit.xml.dist /var/www/html/dev/tests/unit/phpunit.xml.dist
COPY ./composer.json /var/www/html/composer.json
COPY ./composer.lock /var/www/html/composer.lock
COPY ./docker/auth.json /var/www/.composer/
COPY ./update/* /var/www/html/update/

WORKDIR /var/www/html

# Add cron job
ADD docker/crontab /etc/cron.d/magento2-cron
RUN chmod 0644 /etc/cron.d/magento2-cron
RUN crontab -u www-data /etc/cron.d/magento2-cron

RUN chown -R www-data:www-data /var/www/html
RUN su www-data -c "cd /var/www/html && composer install"

EXPOSE 80
