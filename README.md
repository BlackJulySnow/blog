
# 湖南工程学院博客系统

本系统基于Docker搭建，为以Node为基础镜像，Hexo为博客前端，Nginx反向代理4000

去除了博客的Header部分，融合进OJ的主页


## 1.构建命令为
```shell
docker build -t node:hexo .
```


## 2.运行命令为
```shell
docker run --name hexo \ 
    --restart=always \
    -v ~/hexo:/blog \
    -p 4000:4000 \
    -itd \
    node:hexo
```

## 3.如果需要安装插件则需要进入docker进行安装，

```shell
docker exec -it hexo sh
npm install plugin --save
```

## 4.如果需要安装主题，可以直接在hexo目录下执行git clone 主题仓库

```shell
git clone https://github.com/iissnan/hexo-theme-next themes/next
```
