---
title: "Tracepath工具的使用"
description: "This description will be used for the article listing and search results on Google."
date: "2023-04-23"
banner:
  src: "../../images/trace_path.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.redhat.com%2Fsysadmin%2Ftraceroute-tracepath-network-troubleshooting&psig=AOvVaw3_8HyqcymlhORgyqfl1xZh&ust=1714792994554000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMjooe7D8IUDFQAAAAAdAAAAABAE">Red Hat</a></u>'
categories:
  - "工具"
  - "教程"
keywords:
  - "Tracepath"
---

## tracepath 的用途

Linux 中的 tracepath 命令允许使用 UDP 端口或不需要任何超级用户权限的任何其他端口来跟踪到目标路径的路径，确定沿此路径的 MTU（maxium transimission unit 最大传输单元）。

## tracepath 的使用

- `tracepath` : 提示你该如何使用 tracepath
- `tracepath <<destination>>` : 查询通往 destination 的路径信息
- `tracepath -n <<destination>>` : 只显示路由 IP 地址
- `tracepath -b <<destination>>` : 同时显示路由域名和 IP 地址
- `tracepath -m <<number>> <<destination>>` : 规定最大跳数（经过的路由节点数量）（不指定则为 30 个）
- `tracepath -l <<number>> <<destination>>` : 规定包字节大小（不懂捏）
- `tracepath -p <<destination>>` : 允许指定端口被使用（不懂捏）

### 例子展示

Q：  
现在我想知道通往`gaia.cs.umass.edu`的最后一个路由，即在你与服务端这条路径上距离`gaia.cs.umass.edu`最近的一个路由地址，请告诉我吧。  
A：  
执行命令`tracepath -b gaia.cs.umass.edu`
结果:在 30 跳以后，发现仍未到达服务端，于是设定最大跳数为 50 跳。
![](/images/tracepath_fail_result.png)

执行命令`tracepath -b -m 50 gaia.cs.umass.edu`
结果:成功了，gaia.cs.umass.edu 的上一个路由为`nscs1bbs1.cs.umass.edu (128.119.240.253)`
![](/images/tracepath_success_result.png)

## tracepath 显示数据解释

- 显示的毫秒数为`rtt`(round trip time)环回时间，tracepath 向该 router 发送一个数据包，与此同时，tracepath 记录下发送的时刻，router 在收到数据包后，向 tracepath 发送回复，此时再记录下接收到回复的时刻，这段经过的时间便为`rtt`
  - 影响`rtt`的因素有转发处理时间（processing time）、排队时间（queuing time）、数据传输时间（transmission time）、传播时间（propogation time），我们知道，数据包由发出地到目的地所花费的时间为 D<sub>nodal</sub> = D<sub>proc</sub> + D<sub>queue</sub> + D<sub>tran</sub> + D<sub>prop</sub>,那么`rtt`的计算方式也大致如此。
- `no reply`，可能是数据包发生了丢失，或是 router 拒绝回复
