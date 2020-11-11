FROM php:7.4-fpm

# change user and groups ids
RUN usermod --uid=1000 www-data && \
    groupmod --gid=1000 www-data && \
    # fix permissions
    chown -R www-data:www-data /var/www/

# install utilities
## depends on apt-get install
RUN apt-get update && \
    ## git
    apt-get install -y git zip gnupg && \
    ## cleanup
    rm -r /var/lib/apt/lists/* && \
    docker-php-source delete

# install chrome
RUN echo start && \
    curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get -y install google-chrome-stable && \
    ## cleanup
    rm -r /var/lib/apt/lists/* && \
    docker-php-source delete

# Download chromedriver for current chrome version
# https://chromedriver.chromium.org/downloads/version-selection
RUN echo START && \
    # e.g. 86.0.4240.193
    CHROME_VERSION=`google-chrome-stable --version | awk '{ print $NF }'` && \
    echo "CHROME_VERSION: $CHROME_VERSION" && \
    # take first 3 digits, e.g 86.0.4240
    CHROME_VERSION_SHORT=`echo $CHROME_VERSION | sed -E 's/\.([^\.]+)$//'` && \
    echo "CHROME_VERSION_SHORT: $CHROME_VERSION_SHORT" && \
    DRIVER_VERSION=`curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION_SHORT` && \
    echo "DRIVER_VERSION: $DRIVER_VERSION" && \
    curl --remote-name https://chromedriver.storage.googleapis.com/$DRIVER_VERSION/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/bin/chromedriver && \
    echo "Chrome version": && \
    /usr/bin/chromedriver --version && \
    echo END

ENV PANTHER_CHROME_DRIVER_BINARY /usr/bin/chromedriver
ENV PANTHER_CHROME_ARGUMENTS='--disable-dev-shm-usage'

# install composer
ADD ./docker/install-composer.sh /usr/bin
RUN /usr/bin/install-composer.sh && \
    mv composer.phar /usr/bin/composer && \
    rm -f /usr/bin/composer-setup.php && \
    echo END

# install php dependencies
RUN apt-get update && \
    ## zip
    apt-get install -y libzip-dev && \
    docker-php-ext-install zip && \
    ## cleanup
    rm -r /var/lib/apt/lists/* && \
    docker-php-source delete
