#!/bin/bash

CONTAINER_NAME="demo-ad-audits"
DUMP_FILENAME="cyber-security-ad-50.dump"

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
    --env NEO4J_dbms_unmanaged__extension__classes="n10s.endpoint=/rdf" \
    --env NEO4J_PLUGINS='["graph-data-science","apoc"]' \
    neo4j:5.16.0-enterprise

# docker exec $CONTAINER_NAME \
#     bin/neo4j-admin database load \
#     --from-path=https://github.com/neo4j-graph-examples/cybersecurity/raw/main/data/cyber-security-ad-50.dump \
#     neo4j

docker exec $CONTAINER_NAME bash -c "mkdir /var/lib/neo4j/dump/"
docker cp $DUMP_FILENAME $CONTAINER_NAME:/var/lib/neo4j/dump/neo4j.dump
docker exec $CONTAINER_NAME bash -c "bin/neo4j-admin database load --from-path=/var/lib/neo4j/dump neo4j"
