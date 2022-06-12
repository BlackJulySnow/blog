FROM node:lts-alpine

RUN npm config set registry https://registry.npm.taobao.org && \
        npm install hexo-cli -g && \
        hexo init blog && \
        cd blog && \
        npm install
WORKDIR /blog
CMD ["hexo", "server"]