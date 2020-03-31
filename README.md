# v2ray-deb
## 简介
科学上网工具[Project V](https://www.v2ray.com/)的服务端配置比较复杂，而官网[v2ray-core releases](https://github.com/v2ray/v2ray-core/releases)仅提供了各平台的二进制压缩包，安装部署比较麻烦。
本项目将其打包成Debian/Ubuntu系统上的deb安装包（仅支持64位系统），使您能一键部署v2ray服务端，默认使用VMESS协议，安装后自动随机生成端口号和用户ID，您也可以在安装之后修改默认配置文件/etc/v2ray/config.json来重置端口号和用户ID。
## 安装
本项目打包软件的版本号与官网保持一致，您可以直接下载[deb安装包](https://github.com/dreamrover/v2ray-deb/releases)：
* wget https://github.com/dreamrover/v2ray-deb/releases/download/4.23.1/v2ray-4.23.1-amd64.deb
并通过如下命令安装：
* sudo dpkg -i v2ray-4.23.1-amd64.deb

安装后将显示**随机生成的端口号**和**用户ID（UUID）**，并将其填入手机或PC端的v2ray客户端，**额外ID（alterId）为64**。

上述配置信息都保存在/etc/v2ray/config.json中，安装完成后会自动启动v2ray服务。

您可以在安装完成后通过修改文件/etc/v2ray/config.json来自定义端口号和用户ID等配置信息（UUID的格式和长度是固定的，请不要随意修改）。

修改配置文件后须重启v2ray服务使之生效：
* sudo systemctl restart v2ray

生成用户ID（UUID）的方法：
* cat /proc/sys/kernel/random/uuid
## 卸载
您可通过如下命令卸载：
* sudo dpkg -r v2ray
## 自行打包
您也可以自行打包生成deb安装包（AMD64）：
* git clone https://github.com/dreamrover/v2ray-deb.git
* cd v2ray-deb
* chmod +x build.sh
* ./build.sh

如果您需要其他CPU平台的deb安装包，请前官网下载对应的二进制压缩包，并替换此项目中usr/bin/v2ray目录下的可执行文件v2ray和v2ctl，然后安照上述命令生成。
