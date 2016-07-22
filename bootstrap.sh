#!/usr/bin/env bash
# Victor Torres <vpaivatorres@gmail.com>
# August, 11th 2014

# default update
apt-get autoclean -y
apt-get clean -y
apt-get update -y

# installing nodejs
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install nodejs npm -y

# install git
apt-get install git -y

# set rvm directory permission
chmod 755 -R /usr/local/rvm/

# Install Elixir
wget https://s3.amazonaws.com/rebar3/rebar3 -O /usr/bin/rebar3
chmod +x /usr/bin/rebar3
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
rm erlang-solutions_1.0_all.deb
apt-get update -yq --fix-missing
apt-get install -yq git erlang elixir

# Export var for non interactive mode
export DEBIAN_FRONTEND=noninteractive
apt-get -o Dpkg::Options::="--force-confnew" dist-upgrade -y

# Install Phoenix+Postgresql
yes | mix local.hex
yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
apt-get install -yq inotify-tools postgresql-client postgresql postgresql-contrib
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
# setup SQL
cp /vagrant/conf/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
service postgresql restart

# Install Apache+PHP and Nginx
apt-get install -yq nginx apache2 libapache2-mod-php5 php5-pgsql
cp /vagrant/conf/vanilla_site.conf /etc/apache2/sites-enabled/vanilla_site.conf
cp /vagrant/conf/ports.conf /etc/apache2/ports.conf
cp /vagrant/conf/nginx_proxy /etc/nginx/sites-enabled/nginx_proxy
rm /etc/apache2/sites-enabled/000-default.conf
rm /etc/nginx/sites-enabled/default

# Setup Rails Blog
cd /vagrant/strawberry/rails_blog && bundle install

echo "Completed"