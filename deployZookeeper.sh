mkdir -p prometheus
cp /vagrant/jmx_prometheus_javaagent-0.12.0.jar ./prometheus/
cp /vagrant/zookeeper.yaml ./prometheus/
cp /vagrant/zookeeper /etc/init.d/
sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper
cp /vagrant/kafka_2.12-2.4.0.tgz .
tar -zxvf kafka_2.12-2.4.0.tgz
mv kafka_2.12-2.4.0 kafka
sudo yum install java -y
sudo service zookeeper start &