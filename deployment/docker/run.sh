#!/bin/bash

docker network create --driver=bridge neo4j-cluster

docker run --name=server1 --detach --network=neo4j-cluster \
    --publish=7474:7474 --publish=7473:7473 --publish=7687:7687 \
    --hostname=server1 \
    --env NEO4J_initial_server_mode__constraint=PRIMARY \
    --env NEO4J_dbms_cluster_discovery_endpoints=server1:5000,server2:5000,server3:5000 \
    --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    --env NEO4J_server_bolt_advertised__address=localhost:7687 \
    --env NEO4J_server_http_advertised__address=localhost:7474 \
    --env NEO4J_AUTH=neo4j/password \
    neo4j:5.17.0-enterprise

docker run --name=server2 --detach --network=neo4j-cluster \
    --publish=8474:7474 --publish=8473:7473 --publish=8687:7687 \
    --hostname=server2 \
    --env NEO4J_initial_server_mode__constraint=PRIMARY \
    --env NEO4J_dbms_cluster_discovery_endpoints=server1:5000,server2:5000,server3:5000 \
    --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    --env NEO4J_server_bolt_advertised__address=localhost:8687 \
    --env NEO4J_server_http_advertised__address=localhost:8474 \
    --env NEO4J_AUTH=neo4j/password \
    neo4j:5.17.0-enterprise

docker run --name=server3 --detach --network=neo4j-cluster \
    --publish=9474:7474 --publish=9473:7473 --publish=9687:7687 \
    --hostname=server3 \
    --env NEO4J_initial_server_mode__constraint=PRIMARY \
    --env NEO4J_dbms_cluster_discovery_endpoints=server1:5000,server2:5000,server3:5000 \
    --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    --env NEO4J_server_bolt_advertised__address=localhost:9687 \
    --env NEO4J_server_http_advertised__address=localhost:9474 \
    --env NEO4J_AUTH=neo4j/password \
    neo4j:5.17.0-enterprise