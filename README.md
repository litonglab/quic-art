[![Linux and MacOS build status](https://ci.appveyor.com/api/projects/status/x790ve5msewmva2b/branch/master?svg=true)](https://ci.appveyor.com/project/litespeedtech/lsquic-linux/branch/master)
[![Windows build status](https://ci.appveyor.com/api/projects/status/ij4n3vy343pkgm1j/branch/master?svg=true)](https://ci.appveyor.com/project/litespeedtech/lsquic-windows/branch/master)
[![FreeBSD build status](https://api.cirrus-ci.com/github/litespeedtech/lsquic.svg)](https://cirrus-ci.com/github/litespeedtech/lsquic)
[![Documentation Status](https://readthedocs.org/projects/lsquic/badge/?version=latest)](https://lsquic.readthedocs.io/en/latest/?badge=latest)

# About

This repository contains the source code of ART, a.k.a, QUIC-ART, an implementation based on the open-source [LiteSpeed QUIC (LSQUIC) Library](https://github.com/litespeedtech/lsquic).

ART is short for Adaptive ReTransmission. ART is a sender-side scheme, which minimizes the recovery time of lost packets with minimal redundancy cost. Distinguishing itself from forward-error-correction (FEC), which preemptively sends redundant data packets to prevent loss, ART functions as an automatic-repeat-request (ARQ) scheme. It applies redundancy specifically to lost packets instead of unlost packets, thereby addressing the characteristic patterns of wide-area losses in real-world scenarios.

Please cite this paper as follows:

- Tong Li, Wei Liu, Xinyu Ma, Shuaipeng Zhu, Jinkun Cao, Senzhen Liu, Taotao Zhang, Yinfeng Zhu, Bo Wu, Ke Xu. ART: Adaptive Retransmission for Wide-Area Loss Recovery in the Wild. IEEE International Conference on Network Protocols (ICNP), pp.1-11, 2023.10.10.

The way to build QUIC-ART is similar to LSQUIC. Please follow the instructions below (referred from the LiteSpeed Team https://github.com/litespeedtech/lsquic).

# LiteSpeed QUIC (LSQUIC) Library README

## Description

LiteSpeed QUIC (LSQUIC) Library is an open-source implementation of QUIC
and HTTP/3 functionality for servers and clients.  Most of the code in this
distribution is used in our own products: LiteSpeed Web Server, LiteSpeed ADC,
and OpenLiteSpeed.

Currently supported QUIC versions are v1, Internet-Draft versions 29, and 27;
and the older "Google" QUIC versions Q043, Q046, an Q050.

## Documentation

Documentation is available at https://lsquic.readthedocs.io/en/latest/.

In addition, see example programs for API usage and EXAMPLES.txt for
some compilation and run-time options.

## Requirements

To build LSQUIC, you need CMake, zlib, and BoringSSL.  The example program
uses libevent to provide the event loop.

> Tips: The recommended Linux Distribution is Ubuntu 18.04.

## Building BoringSSL

BoringSSL is not packaged; you have to build it yourself.  The process is
straightforward.  You will need `go` installed.

1. Clone BoringSSL by issuing the following command:

```
git clone https://boringssl.googlesource.com/boringssl
cd boringssl
```

We also provide [snapshot](https://github.com/litonglab/Boringssl) for users in China, where may be inconvenient to access google source.

You may need to install pre-requisites like zlib and libevent.

2. Use specific BoringSSL version

```
git checkout a9670a8b476470e6f874fef3554e8059683e1413
```

3. Compile the library

```
cmake . &&  make
```

Remember where BoringSSL sources are:
```
BORINGSSL=$PWD
```

If you want to turn on optimizations, do

```
cmake -DCMAKE_BUILD_TYPE=Release . && make
```

If you want to build as a library, (necessary to build lsquic itself
as as shared library) do:

```
cmake -DBUILD_SHARED_LIBS=1 . && make
```

## Building LSQUIC Library
-----------------------

LSQUIC's `http_client`, `http_server`, and the tests link BoringSSL
libraries statically.  Following previous section, you can build LSQUIC
as follows:

1. Get the source code

```
git clone https://github.com/litespeedtech/lsquic.git
cd lsquic
git submodule init
git submodule update
```

2. Compile the library

Statically:

```
# $BORINGSSL is the top-level BoringSSL directory from the previous step
cmake -DBORINGSSL_DIR=$BORINGSSL .
make
```

As a dynamic library:

```
cmake -DLSQUIC_SHARED_LIB=1 -DBORINGSSL_DIR=$BORINGSSL .
make
```


3. Run tests

```
make test
```

## Building with Docker

The library and the example client and server can be built with Docker.

Initialize Git submodules:
```
cd lsquic
git submodule init
git submodule update
```

Build the Docker image:
```
docker build -t lsquic .
```

Then you can use the examples from the command line.  For example:
```
sudo docker run -it --rm lsquic http_client -s www.google.com  -p / -o version=h3-29
sudo docker run -p 12345:12345/udp -v /path/to/certs:/mnt/certs -it --rm lsquic http_server -c www.example.com,/mnt/certs/chain,/mnt/certs/key
```

## Platforms

The library has been tested on the following platforms:
- Linux
  - i386
  - x86_64
  - ARM (Raspberry Pi 3)
- FreeBSD
  - i386
- MacOS
  - x86_64
- iOS
  - ARM
- Android
  - ARM
- Windows
  - x86_64
