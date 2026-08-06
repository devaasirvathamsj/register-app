#!/bin/bash
set -e

########################################
# Update System
########################################

sudo apt update
sudo apt upgrade -y

########################################
# Install PostgreSQL 18
########################################

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo tee /etc/apt/trusted.gpg.d/pgdg.asc >/dev/null

sudo apt update

sudo apt install -y postgresql-18 postgresql-client-18

sudo systemctl enable postgresql
sudo systemctl start postgresql

########################################
# Configure PostgreSQL
########################################

sudo -u postgres psql <<EOF
CREATE USER sonar WITH ENCRYPTED PASSWORD 'sonar';
CREATE DATABASE sonarqube OWNER sonar;
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;
EOF

########################################
# Install Java 17 (Adoptium)
########################################

sudo mkdir -p /etc/apt/keyrings

wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | \
sudo tee /etc/apt/keyrings/adoptium.asc >/dev/null

echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print $2}' /etc/os-release) main" | \
sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt update

sudo apt install -y temurin-17-jdk unzip wget

java -version

########################################
# Kernel Tuning
########################################

echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
echo "fs.file-max=65536" | sudo tee -a /etc/sysctl.conf

sudo sysctl -p

########################################
# Download SonarQube
########################################

cd /tmp

wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip

sudo unzip sonarqube-9.9.0.65466.zip -d /opt

sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube

########################################
# Create Sonar User
########################################

sudo groupadd sonar

sudo useradd \
-r \
-d /opt/sonarqube \
-g sonar \
-s /bin/bash \
sonar

sudo chown -R sonar:sonar /opt/sonarqube

########################################
# Configure SonarQube
########################################

sudo tee -a /opt/sonarqube/conf/sonar.properties >/dev/null <<EOF

sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube

EOF

########################################
# Limits
########################################

echo "sonar - nofile 65536" | sudo tee -a /etc/security/limits.conf
echo "sonar - nproc 4096" | sudo tee -a /etc/security/limits.conf

########################################
# Systemd Service
########################################

sudo tee /etc/systemd/system/sonar.service >/dev/null <<EOF
[Unit]
Description=SonarQube Service
After=network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

User=sonar
Group=sonar

Restart=always

LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOF

########################################
# Start SonarQube
########################################

sudo systemctl daemon-reload

sudo systemctl enable sonar

sudo systemctl start sonar

sudo systemctl status sonar