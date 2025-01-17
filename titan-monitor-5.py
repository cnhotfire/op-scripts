#!/usr/bin/env python3

import os
import socket
import subprocess
import smtplib
from datetime import datetime, timezone, timedelta
from email.mime.text import MIMEText
import time

# 设置正确的 PATH，包含 titan-edge 所在的目录
os.environ["PATH"] += os.pathsep + "/usr/local/bin/"

# 获取主机名
hostname = socket.gethostname()


# 获取当前系统时间，并指定东八区时区
current_time = (datetime.now(timezone(timedelta(hours=8)))).strftime("%Y-%m-%d %H:%M:%S %Z")

# 启动进程
def start_process(process_name, edge_repo_path):
    log_file = f"{process_name}.log"
    command = f"nohup {process_name} --edge-repo={edge_repo_path} daemon start --url https://cassini-locator.titannet.io:5000/rpc/v0 > {log_file} 2>&1 &"
    subprocess.Popen(command, shell=True, preexec_fn=os.setsid)

if __name__ == "__main__":
   # 生成进程列表
    num_processes = 5
    base_path = "/data/titan"
    processes = []
    for i in range(1, num_processes + 1):
        process_name = f"titan-edge{i:02d}"
        repo_path = f"{base_path}{i:02d}/"
        processes.append({"name": process_name, "repo_path": repo_path})


    # 用于存储重启通知的字符串
    restart_notification = ""

    for process in processes:
        process_name = process["name"]
        edge_repo_path = process["repo_path"]

        # 检查进程是否已经存在
        if not subprocess.Popen(["pgrep", "-x", process_name], stdout=subprocess.PIPE).communicate()[0]:
            print(f"{current_time} - {process_name} 进程不存在，正在尝试重启...")
            start_process(process_name, edge_repo_path)
            time.sleep(3)  # 等待3秒以确保进程启动

            # 添加进程重启信息到重启通知字符串
            restart_notification += f"{current_time} - 主机名：{hostname}\n{process_name} 进程已重启\n"

    print(f"{current_time} - 所有进程已检查完毕.")