---
title: "TCP与UDP"
description: "This description will be used for the article listing and search results on Google."
date: "2023-04-29"
banner:
  src: "../../images/kelly-sikkema-Hl3LUdyKRic-unsplash.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://unsplash.com/photos/Nc5Q_CEcY44">Florian Olivo</a></u>'
categories:
  - "Setup"
  - "Tutorial"
keywords:
  - "Example"
---
## 前置
我们知道，在计算机网络中，应用层即一个个大大小小的进程，不同的进程对于数据传输有着不同的需求，如邮件和文件传输以及web浏览要求数据的完整性，但不会对延迟和数据吞吐量作出太多要求，而视频服务则要求吞吐量达到一定标准，允许一定的数据丢包；游戏则要求极低的延迟，允许数据丢包。

那么这些不同的数据传输需求在传输层上就体现为两个协议--TCP和UDP，他们制定了数据传输的规则和方式，使得数据传输呈现出多样性。

## TCP
TCP，全称Transmission Control Protocol，他拥有以下几个特点：
- 可靠的传输，会验证数据的完整性。
- 流控制，当发送数据的速度大于接收端可以接受的数据速度时，发送端会被限速。
- 溢出控制，限制发送者的数据速度，使其小于网络能够传输的速度。比如同样的一个WLAN，在被更多人使用时（假设都处于活跃状态），那么每个人的网速都会相应的降低。
- 连接导向。需要有事先建立好的连接（传输介质：光缆，电缆等；router，ISP），得先有路。
- 不提供时效性，最小吞吐量保证和安全性（明文传输）。

## UDP
UDP，全称User Datagram Protocols,他拥有以下几个特点：
- 不提供TCP拥有的。
- TCP不提供的，他也没有。
- 但很多其他的传输协议是在UDP的框架上建立的。（服务供应商可以建立私有的传输协议以更好的符合他们的业务要求）

## TCP和UDP的应用
