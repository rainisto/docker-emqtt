# Docker for [emqtt](http://emqtt.io/)

Example of running HA emqtt cluster on 3 docker machines. You can also put HA proxy in front if needed.
```
192.168.1.7# docker run -d --name emqtt-master --net=host -e NODE_IP=192.168.1.7 rainisto/emqtt
192.168.1.8# docker run -d --name emqtt-node1 --net=host -e NODE_IP=192.168.1.8 -e MASTER=192.168.1.7 rainisto/emqtt
192.168.1.9# docker run -d --name emqtt-node2 --net=host -e NODE_IP=192.168.1.9 -e MASTER=192.168.1.7 rainisto/emqtt
ha_host# docker run -d --name haproxy-emqtt --net=host -v haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg rainisto/haproxy-emqtt
```
    
Example of running cluster inside swarm overlay network. (Add HAproxy in front to publish the needed ports)
```
docker network create --driver overlay --subnet 10.0.1.0/24 mqtt
docker service create --constraint "node.hostname==node1.local" --name emqtt-master --network mqtt -e NODE_IP=emqtt-master rainisto/emqtt
docker service create --constraint "node.hostname==node2.local" --name emqtt-node1 --network mqtt -e NODE_IP=emqtt-node1 -e MASTER=emqtt-master rainisto/emqtt
docker service create --constraint "node.hostname==node3.local" --name emqtt-node2 --network mqtt -e NODE_IP=emqtt-node2 -e MASTER=emqtt-master rainisto/emqtt
docker service create --name haproxy-emqtt --network mqtt -p 1883:1883 -p 18083:18083 rainisto/haproxy-emqtt
docker service scale haproxy-emqtt=3
```
