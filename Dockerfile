FROM ubuntu
MAINTAINER wujtruj <wujtruj@engineer.com>

# Update OS
RUN apt-get update
RUN apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y wget unzip apache2 libapache2-mod-php5

# Download and unpack Dropplets
RUN wget --no-check-certificate -O /tmp/dropplets.zip https://github.com/circa75/dropplets/archive/master.zip
RUN unzip /tmp/dropplets.zip -d /var/www/
RUN rm /tmp/dropplets.zip
RUN mv /var/www/dropplets-master/ /var/www/dropplets/
RUN chown -R www-data: /var/www/

# Configure apache2
RUN a2dissite 000-default
ADD apache2/dropplets /etc/apache2/sites-available/dropplets
RUN a2ensite dropplets
RUN a2enmod rewrite

# Configure apache2 variables
ENV APACHE_RUN_USER    www-data
ENV APACHE_RUN_GROUP   www-data
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2
ENV APACHE_LOG_DIR     /var/log/apache2
ENV LANG               C

# Expose default http port (:80)
EXPOSE 80

# Run apache2 in foreground as an entrypoint
ENTRYPOINT ["apache2", "-D", "FOREGROUND"]
