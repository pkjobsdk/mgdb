#!/bin/bash
cd /opt/
echo "Download mongdb software..."
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1404-3.0.4.tgz
echo " mongdb software..."
tar -zxf mongodb-linux*.tgz
mkdir software
mv mongodb-linux-*.tgz software
mv mongodb-linux* mongodb
cd mongodb/

echo "create log,data,conf dir and create mongodb.log , mongod.conf"
mkdir log data conf
cd log/
touch mongodb.log 
cd ..

cd conf
echo "port = 12345
dbpath = data
logpath = log/mongod.log
fork = true   #在linux中fork为启动后台命令" >> mongod.conf
cd ..

echo "create mongod.conf and transfer to /usr/bin"
echo "#!/bin/bash
cd /opt/mongodb/
./bin/mongod -f conf/mongod.conf 
cd - " >> mongod.sh
mv mongod.sh /usr/bin/
chmod a+x /usr/bin/mongod.sh

echo "Modify /etc/bash.bashrc"
echo "alias mongod='/usr/bin/mongod.sh'" >> /etc/bash.bashrc
source /etc/bash.bashrc
cd -