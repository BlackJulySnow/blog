#!/bin/bash

kill -9 $(lsof -t -i:4000)
cd /blog && nohup hexo server > hexo.log 1>&1 &


