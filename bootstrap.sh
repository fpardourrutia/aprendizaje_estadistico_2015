#!/usr/bin/env bash
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo apt-get update
sudo apt-get -y install git gcc
sudo apt-get -y install libxml2-dev libcurl3-nss  libcurl4-openssl-dev libssl0.9.8 libcairo2-dev libxt-dev 
sudo apt-get -y install r-base r-base-dev r-cran-rcurl

sudo R -e "install.packages('shiny', repos = 'http://cran.rstudio.com/', dep = TRUE, quiet = TRUE)"
sudo R -e "install.packages('rmarkdown', repos = 'http://cran.rstudio.com/', dep = TRUE, quiet = TRUE)"
sudo Rscript --verbose /vagrant/paquetes_iniciales.R
sudo apt-get -y install gdebi-core
wget -nv https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.0.721-amd64.deb
sudo gdebi shiny-server-1.4.0.721-amd64.deb
wget -nv https://download2.rstudio.org/rstudio-server-0.99.467-amd64.deb
sudo gdebi rstudio-server-0.99.467-amd64.deb
sudo dpkg -i *.deb
rm *.deb


