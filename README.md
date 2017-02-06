# Docker for [emqtt](http://emqtt.io/)

Example of running HA emqtt cluster on 3 docker machines. You can also put HA proxy in front if needed.
```
192.168.1.7# docker run -d --name emqtt-mastr --net=host -e NODE_IP=192.168.1.7 rainisto/emqtt
192.168.1.8# docker run -d --name emqtt-node1 --net=host -e NODE_IP=192.168.1.8 -e MASTER=192.168.1.7 rainisto/emqtt
192.168.1.9# docker run -d --name emqtt-node2 --net=host -e NODE_IP=192.168.1.9 -e MASTER=192.168.1.7 rainisto/emqtt
```

