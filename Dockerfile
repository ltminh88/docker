FROM ubuntu:14.04.5


# Update package list
RUN apt-get -y update


# Install dependences package for ruby environment 
RUN apt-get install -y patch curl imagemagick libmagickcore-dev libmagickwand-dev build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion libmysqlclient18 libmysqlclient-dev mysql-server  memcached mongodb monit graphviz nodejs redis-server acct sysv-rc-conf tomcat6 tomcat6-admin postfix mailutils libsasl2-2 ca-certificates libsasl2-modules vim htop libcurl4-openssl-dev npm libicu-dev libgdbm-dev libncurses5-dev libreadline-dev libffi-dev checkinstall logrotate
# Config uft8 mysql

#RUN echo "[client]" > /etc/mysql/conf.d/utf8.cnf
#RUN echo "default-character-set=utf8mb4" >> /etc/mysql/conf.d/utf8.cnf
#RUN echo "[mysql]" >> /etc/mysql/conf.d/utf8.cnf
#RUN echo "default-character-set=utf8mb4" >> /etc/mysql/conf.d/utf8.cnf
#RUN echo "[mysqld]" >> /etc/mysql/conf.d/utf8.cnf
#RUN echo "collation-server = utf8mb4_unicode_ci" >> /etc/mysql/conf.d/utf8.cnf
#RUN echo "init-connect='SET NAMES utf8mb4'" >> /etc/mysql/conf.d/utf8.cnf
#RUN echo "character-set-server = utf8mb4" >> /etc/mysql/conf.d/utf8.cnf 

# Install Rvm, Ruby and Bundler
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN  \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash /etc/profile.d/rvm.sh
RUN /bin/bash -l -c "rvm install 2.3.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN apt-get update && apt-get install --yes nodejs

# Copy Gemfile from local to container
COPY Gemfile /cache/Gemfile
COPY Gemfile.lock /cache/Gemfile.lock

# Install dependences Gem on Gemfile
RUN /bin/bash -l -c "cd /cache && bundle install"

# Run framgia CI 
RUN curl -o /usr/bin/framgia-ci https://raw.githubusercontent.com/framgia/ci-report-tool/master/dist/framgia-ci && chmod +x /usr/bin/framgia-ci
