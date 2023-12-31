# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 安装 SSH 服务和 Shellinabox
RUN apt-get update && \
    apt-get install -y openssh-server shellinabox procps sudo git curl wget htop tree fdisk neofetch screen zsh htop atop vim rsync zip unzip grep sed ncdu tar python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 设置自定义的命令提示符
ENV PS1="\[\e]0;ubuntu: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

# 更改hostname
# RUN echo 'ubuntu' > /etc/hostname

# 更新hosts文件
# RUN flock /etc/hosts -c "sed -i 's/127.0.1.1.*/127.0.1.1\tubuntu/g' /etc/hosts"

# 设置 root 用户的密码为 'root'
RUN echo 'root:adminpassword' | chpasswd

# 暴露 22 和 4200 端口
EXPOSE 22
EXPOSE 4200

# 复制 entrypoint.sh 并赋予执行权限
COPY must.sh /must.sh
RUN chmod +x /must.sh

# 指定 entrypoint.sh 作为容器的入口点
CMD ["/must.sh"]

# 启动 SSH 服务和 Shellinabox
# CMD ["/usr/sbin/sshd", "-D"] && /usr/bin/shellinaboxd -t -s /:LOGIN
