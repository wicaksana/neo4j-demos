#!/bin/bash

CONTAINER_NAME="demo-icij-pandora-papers"

docker run \
    --name $CONTAINER_NAME \
    -p7474:7474 -p7687:7687 \
    -d \
    -v $PWD/neo4j/data:/data \
    -v $PWD/neo4j/logs:/logs \
    -v $PWD/neo4j/import:/var/lib/neo4j/import \
    -v $PWD/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/password \
    --env NEO4J_ACCEPT_LICENSE_AGREEMENT="yes" \
    --env NEO4J_server_memory_heap_max__size="4G" \
    --env NEO4J_PLUGINS='["graph-data-science","apoc"]' \
    neo4j:4.4.31-enterprise

docker exec $CONTAINER_NAME \
    bash -c \
    'mkdir -p dump; 
    wget -O dump/icij.dump https://github.com/neo4j-graph-examples/icij-offshoreleaks/raw/main/data/icij-offshoreleaks-44.dump;
    bin/neo4j-admin load --from=dump/icij.dump --database=icij;
    echo "CREATE DATABASE icij;" > db.cypher; bin/cypher-shell -u neo4j -p password -f db.cypher'
