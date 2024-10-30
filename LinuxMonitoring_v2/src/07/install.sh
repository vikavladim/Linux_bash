sudo apt update
sudo apt install -y libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.3.6_amd64.deb
sudo dpkg -i grafana_9.3.6_amd64.deb
rm -rf grafana_9.3.6_amd64.deb
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo apt install -y prometheus
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl restart grafana-server