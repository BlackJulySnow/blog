
# 湖南工程学院博客系统

本系统基于Docker搭建，为以Node为基础镜像，Hexo为博客前端，Nginx反向代理4000

去除了博客的Header部分，融合进OJ的主页


构建命令为
```shell
docker build -t node:hexo .
```


运行命令为
```shell
docker run --name blog \ 
    --restart=always \
    -v ~/hexo:/blog \
    -p 4000:4000 \
    -itd \
    node:hexo
```
