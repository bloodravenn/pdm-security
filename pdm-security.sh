#!/bin/sh

sudo apt install -y lynis
sudo lynis audit system
sudo docker stop pdm-security
sudo docker rm pdm-security
git clone https://github.com/d4t4king/lynis-report-converter
cd lynis-report-converter
mkdir log
sudo cp /var/log/lynis-report.dat ./log/
sudo chmod 755 log/lynis-report.dat
sudo docker build -t pdm-security .
sudo docker run --rm -v ./log:/reports pdm-security -j /reports/report.json -i /reports/lynis-report.dat > lynis-report.json
sudo cp lynis-report.json /var/log/lynis-report.json
cd ..
sudo rm -rf  lynis-report-converter
sudo apt remove lynis
