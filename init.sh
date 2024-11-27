#!/bin/bash
mkdir -p /data/titan01/storage

wget -c https://github.com/Titannet-dao/titan-node/releases/download/v0.1.20/titan-edge_v0.1.20_246b9dd_linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local/bin --strip-components=1
mv /usr/local/bin/titan-edge /usr/local/bin/titan-edge01
mv /usr/local/bin/libgoworkerd.so /usr/lib/

titan-edge01 --edge-repo=/data/titan01/  config set --listen-address="0.0.0.0:12341" --storage-path=/data/titan01/storage --storage-size=50GB daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 && nohup titan-edge01 --edge-repo=/data/titan01/ daemon start --url https://cassini-locator.titannet.io:5000/rpc/v0 > /root/titan-edge01.log 2>&1 &
sleep 5
titan-edge01 --edge-repo=/data/titan01/ bind --hash=02202BD2-26B7-4ACC-899F-BF32174D7224 https://api-test1.container1.titannet.io/api/v2/device/binding


mkdir -p /data/titan02/storage
cp /usr/local/bin/titan-edge01 /usr/local/bin/titan-edge02
titan-edge02 --edge-repo=/data/titan02/  config set --listen-address="0.0.0.0:12342" --storage-path=/data/titan02/storage --storage-size=50GB daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 && nohup titan-edge02 --edge-repo=/data/titan02/ daemon start --url https://cassini-locator.titannet.io:5000/rpc/v0 > /root/titan-edge02.log 2>&1 &
sleep 5
titan-edge02 --edge-repo=/data/titan02/ bind --hash=02202BD2-26B7-4ACC-899F-BF32174D7224 https://api-test1.container1.titannet.io/api/v2/device/binding

mkdir -p /data/titan03/storage
cp /usr/local/bin/titan-edge01 /usr/local/bin/titan-edge03
titan-edge03 --edge-repo=/data/titan03/  config set --listen-address="0.0.0.0:12343" --storage-path=/data/titan03/storage --storage-size=50GB daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 && nohup titan-edge03 --edge-repo=/data/titan03/ daemon start --url https://cassini-locator.titannet.io:5000/rpc/v0 > /root/titan-edge03.log 2>&1 &
sleep 5
titan-edge03 --edge-repo=/data/titan03/ bind --hash=02202BD2-26B7-4ACC-899F-BF32174D7224 https://api-test1.container1.titannet.io/api/v2/device/binding

mkdir -p /data/titan04/storage
cp /usr/local/bin/titan-edge01 /usr/local/bin/titan-edge04
titan-edge04 --edge-repo=/data/titan04/  config set --listen-address="0.0.0.0:12344" --storage-path=/data/titan04/storage --storage-size=50GB daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 && nohup titan-edge04 --edge-repo=/data/titan04/ daemon start --url https://cassini-locator.titannet.io:5000/rpc/v0 > /root/titan-edge04.log 2>&1 &
sleep 5
titan-edge04 --edge-repo=/data/titan04/ bind --hash=02202BD2-26B7-4ACC-899F-BF32174D7224 https://api-test1.container1.titannet.io/api/v2/device/binding

mkdir -p /data/titan05/storage
cp /usr/local/bin/titan-edge01 /usr/local/bin/titan-edge05
titan-edge05 --edge-repo=/data/titan05/  config set --listen-address="0.0.0.0:12345" --storage-path=/data/titan05/storage --storage-size=50GB daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 && nohup titan-edge05 --edge-repo=/data/titan05/ daemon start --url https://cassini-locator.titannet.io:5000/rpc/v0 > /root/titan-edge05.log 2>&1 &
sleep 5
titan-edge05 --edge-repo=/data/titan05/ bind --hash=02202BD2-26B7-4ACC-899F-BF32174D7224 https://api-test1.container1.titannet.io/api/v2/device/binding



rc.vidmage.ai.akamaized.net
