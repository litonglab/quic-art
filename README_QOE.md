# 实验环境搭建及测试

## 1. 安装 Mahimahi

在终端中运行以下命令：

```bash
sudo apt-get install build-essential git debhelper autotools-dev dh-autoreconf iptables protobuf-compiler libprotobuf-dev pkg-config libssl-dev dnsmasq-base ssl-cert libxcb-present-dev libcairo2-dev libpango1.0-dev iproute2 apache2-dev apache2-bin iptables dnsmasq-base gnuplot iproute2 apache2-api-20120211 libwww-perl
```

然后克隆 Mahimahi 仓库并编译：

```bash
git clone https://github.com/ravinet/mahimahi
cd mahimahi
./autogen.sh && ./configure && make
sudo make install
```

确保安装成功：

```bash
mm-delay 20
```

（注意：`mm-delay` 运行前需要执行命令 `sudo sysctl -w net.ipv4.ip_forward=1`）

## 2. 使用 OpenSSL 工具生成证书和私钥

在终端中运行以下命令：

```bash
# 生成私钥文件（.key）
openssl genpkey -algorithm RSA -out /path/to/private.key

# 生成证书签名请求文件（.csr）
openssl req -new -key /path/to/private.key -out /path/to/request.csr

# 生成自签名证书文件（.crt）
openssl x509 -req -days 365 -in /path/to/request.csr -signkey /path/to/private.key -out /path/to/certificate.crt
```

## 3. 下载视频文件

从 [BigBuckBunny 数据集](https://ftp.itec.aau.at/datasets/DASHDataset2014/BigBuckBunny/) 下载 `1sec` 文件夹中的所有文件（包括 mpd 文件以及相应的 .m4s 文件）。

## 4. 下载 quic-art 代码

在终端中运行以下代码：

```bash
git clone https://github.com/litonglab/quic-art.git
cd quic-art/
git fetch origin qoe_about_art
git checkout -b qoe_about_art origin/qoe_about_art
git branch
```

修改 `client` 下的 `config_dash.py` 中的 `QUIC_DOWNLOAD_FOLDER` 和 `QUIC_CLIENT_CMD`：

```python
QUIC_DOWNLOAD_FOLDER = "/home/user/download"
QUIC_CLIENT_CMD="/home/user/quic-art/bin/http_client -H " + "www.litongquic.tk"+ " -s 100.64.0.1:12345 -L INFO -t -7 " + QUIC_DOWNLOAD_FOLDER + " -p "
```

## 5. 进行测试

在终端中运行以下代码以开启服务端：

```bash
/home/user/quic-art/bin/http_server -c www.litongquic.tk,-c www.litongquic.tk,/path/to/certificate.crt,/path/to/private.key -L debug -r /home/user/1sec -s 0.0.0.0:12345
```

命令解释：

- `/home/user/quic-art/bin/http_server`: 指定 QUIC 协议的 HTTP 服务器。
- `-c www.litongquic.tk,/path/to/certificate.crt,/path/to/private.key`: 使用 `-c` 选项后接的参数是服务器的证书配置信息，确保通信的安全性。
- `-L debug`: 使用 `-L` 选项后接的参数是服务器的日志级别，这里是 debug，表示输出详细的调试信息。
- `-r /home/user/1sec`: 使用 `-r` 选项后接的参数是服务器提供的文件的根目录，即客户端可以从服务器获取的文件将从这个目录开始查找。
- `-s 0.0.0.0:12345`: 使用 `-s` 选项后接的参数是服务器监听的地址和端口，这里是 0.0.0.0:12345，表示服务器将在所有可用的网络接口上监听端口 12345。

在新终端中模拟网络延迟为30ms、丢包率为0.1的网络连接：

```bash
mm-link /home/user/mahimahi/traces/Verizon-LTE-driving.up /home/user/mahimahi/traces/Verizon-LTE-driving.down mm-delay 30 mm-loss downlink 0.1
```

继续在此终端中运行以下命令以开启客户端，即借助 mpd 文件使用 QUIC 协议进行媒体传输（请pip安装相应的python库）：

```bash
python /home/user/quic-art/client/dash_client.py -m http://100.0.64.1:12345/BigBuckBunny_1s_simple_2014_05_09.mpd -quic
```
实验结果可以在 `quic-art/client/ASTREAM_LOGS/` 中查看。
