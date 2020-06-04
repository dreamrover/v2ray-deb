# v2ray-deb
## 简介
科学上网工具[Project V](https://www.v2ray.com/)的Linux服务端/客户端配置比较复杂，而官网[v2ray-core releases](https://github.com/v2ray/v2ray-core/releases)仅提供了各平台的二进制压缩包，安装部署比较麻烦。

本项目将其打包成Debian/Ubuntu系统上的deb安装包（仅提供x86_64版，如需其他CPU平台的安装包请[自行打包](https://github.com/dreamrover/v2ray-deb#%E8%87%AA%E8%A1%8C%E6%89%93%E5%8C%85)），使您能一键部署v2ray的Linux服务端/客户端，默认使用VMESS协议，安装后自动随机生成端口号和用户ID。

配置文件位于/etc/v2ray目录下，服务端和客户端配置文件分别为server.json和client.json，安装完成后默认配置为服务端，创建指向server.json的符号链接文件config.json。您也可以在安装之后修改默认配置文件来重置端口号和用户ID，也可以修改符号链接文件/etc/v2ray/config.json的指向来将其作为客户端使用。

作为服务端时，安装完成后自动生成的端口号为TCP端口号，同时也是基于UDP的mKCP的端口号，UUID相同，您可以在与此服务端连接的客户端使用TCP或mKCP，但不建议您使用m[KCP](https://github.com/skywind3000/kcp)，因为用了之后此端口和IP很快会被探测到进而被封，原因你懂的。另外，安装完成后服务端也默认支持基于UDP的[QUIC](https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%80%9FUDP%E7%BD%91%E7%BB%9C%E8%BF%9E%E6%8E%A5)协议传输，端口号为前述自动生成的端口号加1，UUID相同，key也与UUID相同，同样不建议您使用QUIC，原因与mKCP相同，虽然这两个基于UDP的协议速度更快。

服务端的配置信息都保存在/etc/v2ray/server.json中，包含TCP/mKCP/QUIC。客户端的配置信息都保存在/etc/v2ray/client.json中，仅包含TCP的配置信息，inbounds中的本地socks5代理为1080端口，HTTP代理为8080端口；outbounds中的端口号和UUID与服务端相同。
## 安装
本项目打包软件的版本号与官网保持一致，您可以直接下载[deb安装包](https://github.com/dreamrover/v2ray-deb/releases)：
* wget https://github.com/dreamrover/v2ray-deb/releases/download/4.23.3/v2ray-4.23.3-amd64.deb

并通过如下命令安装：
* sudo dpkg -i v2ray-4.23.3-amd64.deb

安装后将显示**随机生成的端口号**和**用户ID（UUID）**，并将其填入手机或PC端的v2ray客户端，**额外ID（alterId）为64**。

上述配置信息都保存在/etc/v2ray/config.json中（此文件为符号链接，指向同目录下的server.json），安装完成后会自动启动v2ray服务。

您可以在安装完成后通过修改文件/etc/v2ray/config.json来自定义端口号和用户ID等配置信息（UUID的格式和长度是固定的，请不要随意修改）。

修改配置文件后须重启v2ray服务使之生效：
* sudo systemctl restart v2ray

生成用户ID（UUID）的方法：
* cat /proc/sys/kernel/random/uuid

你也可以将符号链接文件/etc/v2ray/config.json指向client.json来将其作为客户端使用（默认不能同时作为服务端和客户端）：
* sudo unlink /etc/v2ray/config.json
* sudo ln -s /etc/v2ray/client.json /etc/v2ray/config.json
## 卸载
您可通过如下命令卸载：
* sudo dpkg -r v2ray
## 自行打包
您也可以自行打包生成deb安装包（AMD64）：
* git clone https://github.com/dreamrover/v2ray-deb.git
* cd v2ray-deb
* chmod +x build.sh
* ./build.sh

如果您需要其他CPU平台的deb安装包，请前官网下载对应的二进制压缩包，并替换此项目中usr/bin/v2ray目录下的可执行文件v2ray和v2ctl，然后按照上述命令生成。
