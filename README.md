# Docker for [emqtt](http://emqtt.io/)

Example of running HA emqtt cluster on 3 docker machines. You can also put HA proxy in front if needed.
```
192.168.1.7# docker run -d --name emqtt-mastr --net=host -e NODE_IP=192.168.1.7 rainisto/emqtt
192.168.1.8# docker run -d --name emqtt-node1 --net=host -e NODE_IP=192.168.1.8 -e MASTER=192.168.1.7 rainisto/emqtt
192.168.1.9# docker run -d --name emqtt-node2 --net=host -e NODE_IP=192.168.1.9 -e MASTER=192.168.1.7 rainisto/emqtt
```

Example of running cluster inside swarm overlay network. (Add HAproxy in front to publish the needed ports)
```
docker network create --driver overlay --subnet 10.0.1.0/24 mqtt
docker service create --constraint "node.hostname==node1.local" --name emqtt-mastr --network mqtt -e NODE_IP=emqtt-mastr rainisto/emqtt
docker service create --constraint "node.hostname==node2.local" --name emqtt-node1 --network mqtt -e NODE_IP=emqtt-node1 -e MASTER=emqtt-master rainisto/emqtt:latest
docker service create --constraint "node.hostname==node3.local" --name emqtt-node2 --network mqtt -e NODE_IP=emqtt-node2 -e MASTER=emqtt-master rainisto/emqtt
```
