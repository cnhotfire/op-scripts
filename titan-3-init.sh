#!/bin/bash

# 创建第一个实例的基础目录
mkdir -p /data/titan01/storage

# 下载并安装基础程序
wget -c https://github.com/Titannet-dao/titan-node/releases/download/v0.1.20/titan-edge_v0.1.20_246b9dd_linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local/bin --strip-components=1
mv /usr/local/bin/titan-edge /usr/local/bin/titan-edge01
mv /usr/local/bin/libgoworkerd.so /usr/lib/

# 循环创建和配置 5 个实例
for i in {1..5}; do
    # 格式化编号为两位数
    num=$(printf "%02d" $i)
    
    # 如果不是第一个实例，则复制可执行文件
    if [ $i -ne 1 ]; then
        mkdir -p /data/titan${num}/storage
        cp /usr/local/bin/titan-edge01 /usr/local/bin/titan-edge${num}
    fi
    
    # 计算端口号
    port=$((12340 + i))
    
    # 配置和启动实例
    titan-edge${num} --edge-repo=/data/titan${num}/ config set \
        --listen-address="0.0.0.0:${port}" \
        --storage-path=/data/titan${num}/storage \
        --storage-size=50GB \
        daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 && \
    nohup titan-edge${num} --edge-repo=/data/titan${num}/ daemon start \
        --url https://cassini-locator.titannet.io:5000/rpc/v0 > /root/titan-edge${num}.log 2>&1 &
    
    # 等待 5 秒后进行绑定
    sleep 5
    
    # 绑定实例
    titan-edge${num} --edge-repo=/data/titan${num}/ bind \
        --hash=02202BD2-26B7-4ACC-899F-BF32174D7224 \
        https://api-test1.container1.titannet.io/api/v2/device/binding
done
