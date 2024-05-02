---
title: "部署hexo博客至云服务器"
description: "This description will be used for the article listing and search results on Google."
date: "2023-12-07"
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

本文将涉及博客搭建的几乎所有内容，按时间排序，步骤可分为
1. 本地电脑部署 
2. 购买域名
3. 给域名备案 
4. 购买服务器
5. 配置服务器 
6. 配置git
7. 服务器端部署hexo 
8. [给网站添加备案信息](#给网站添加备案信息)
9. [给域名添加证书实现https](#给域名添加证书实现https)


## 第一步至第六步请参照下方链接
[只需5步！在轻量应用服务器部署Hexo博客](https://developer.aliyun.com/article/815625#slide-4)


## 给域名备案

给域名备案还是蛮讲究的，请仔细阅读[备案信息填写规范](https://help.aliyun.com/zh/icp-filing/user-guide/fill-in-the-website-information-2?spm=a2c4g.11186623.4.5.5fd63797dcdUK1&scm=20140722.H_36948._.ID_36948-OR_rec-V_1)，查看不同地区的规范要求，注意一些敏感词汇不要使用。

尤其是网站名称的选择，不要选用诗句成语等，也不要选择烂大街的名称（比如网上一些攻略中提供的名称，很有可能被用了很多次了），否则会被驳回。

核心三要素就是 —— 遵守规范、体现网站主要内容、词汇中性或积极

## 给网站添加备案信息
找到footer.ejs文件，通常在`[本地博客文件夹根目录]/themes/[主题名]/layout/_partial/footer.ejs`

打开footer.ejs文件，在合适的位置添加备案信息的html代码，例如

```js
<footer id="footer">
  <div class="footer-left">
    <%= __('footer.copyright') %> &copy;
    <% var endYear = (theme.copyright && theme.copyright.end_year) ? theme.copyright.end_year : new Date().getFullYear() %>
    <% var startYear = (theme.copyright && theme.copyright.start_year) ? theme.copyright.start_year : new Date().getFullYear() %>
    <%= startYear >= endYear ? endYear : startYear + "-" + endYear %>
    <%= config.author || config.title %>
  </div>
  <div class="footer-right">
    <nav>
      <ul>
        <% for (var i in theme.nav) { %><!--
       --><li><a href="<%- url_for(theme.nav[i]) %>"><%= __('nav.'+i).replace("nav.", "") %></a></li><!--
     --><% } %>
      </ul>
    </nav>
  </div>
// 下方是新增的备案代码
  <div>
    <% if (theme.beian) { %>
      <a href="https://beian.miit.gov.cn/" target="_blank"><%= theme.beian %></a>
    <% } %>
  </div>
// 上方是新增的备案代码
</footer>
```

是的，你可以像示例中的那样将备案信息以变量的形式进行存取，方便后续修改，当然，如果你也选择这样做，则还需要在`[本地博客文件夹根目录]/themes/[主题名]/_config.yml`中添加 `beian`变量

```yaml
# beian information
beian: 浙ICP备xxxxxxxx号
```

如果嫌麻烦直接在footer.ejs文件中写明就好，像下面这样。

```js
<div>
      <a href="https://beian.miit.gov.cn/" target="_blank">你的备案号</a>
</div>
```

## 给域名添加证书实现https
这一步很简单，因为有非常厉害的工具 —— [certbot](https://certbot.eff.org/) , 可以自动申请证书，并修改你的服务器中间件(nginx|apache)的配置，开启SSL, 并且证书到期了还能给你自动更新，简直不要太方便。

当然，记得在运行certbot脚本前在云服务器的管理面板开启443端口用于SSL服务。

进入[certbot官网](https://certbot.eff.org/)后，选择你的中间件和操作系统，接着稍稍等待页面的加载，下方就会出现相应的操作指引。

![certbot](./certbot.png)

如下图，这里选的是`software--nginx` 和 `system--ubuntu20`

![Alt text](./certbot2.png)

接着跟着指引一步步来就行啦

在浏览器输入你的域名，看看是否大功告成


