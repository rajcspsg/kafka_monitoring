#!/bin/bash
sudo yum install -y vim nano tar nmap ca-certificates net-tools zip unzip wget
sudo yum install -y java-1.8.0-openjdk

echo "192.168.10.35 kafka1.com
192.168.10.36 kafka2.com
192.168.10.37 kafka3.com
192.168.10.25 zookeeper.com
192.168.10.51 kafkamisc.com" | sudo tee --append /etc/hosts

mkdir -p Installed
cd Installed
#cp  /vagrant/zookeeper-3.4.13.tar.gz /home/vagrant/Installed/
#sudo tar -xvzf zookeeper-3.4.13.tar.gz

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo systemctl start docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cp /vagrant/zoonavigator-docker-compose.yml /home/vagrant/Installed/
#cp /vagrant/kafka-manager-docker-compose.yml /home/vagrant/Installed/

#sudo docker-compose -f kafka-manager-docker-compose.yml up -d
docker-compose -f zoonavigator-docker-compose.yml up -d

wget https://github.com/prometheus/prometheus/releases/download/v2.16.0/prometheus-2.16.0.linux-amd64.tar.gz
sudo tar -zxvf prometheus-2.16.0.linux-amd64.tar.gz
sudo mv prometheus-2.16.0.linux-amd64 prometheus
sudo rm -rf /home/vagrant/Installed/prometheus/prometheus.yml
sudo cp /vagrant/prometheus.yml /home/vagrant/Installed/prometheus/prometheus.yml
sudo /home/vagrant/Installed/prometheus/prometheus --config.file=/home/vagrant/Installed/prometheus/prometheus.yml &
sudo wget https://dl.grafana.com/oss/release/grafana-6.6.2.linux-amd64.tar.gz
sudo tar -zxvf grafana-6.6.2.linux-amd64.tar.gz
sudo cp /vagrant/default.ini /home/vagrant/Installed/grafana/conf/
sudo mv grafana-6.6.2 grafana
sudo rm -f  Installed/grafana/conf/defaults.ini
sudo cp /vagrant/defaults.ini Installed/grafana/conf/
sudo /home/vagrant/Installed/grafana/bin/grafana-server & 
