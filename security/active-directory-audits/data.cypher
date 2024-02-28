///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Load the sample data into Neo4j.
// https://github.com/neo4j-graph-examples/cybersecurity/blob/main/documentation/cybersecurity.adoc
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Prepare schema
CREATE CONSTRAINT group_name IF NOT EXISTS FOR (g:Group) REQUIRE g.name IS UNIQUE;
CREATE CONSTRAINT domain_name IF NOT EXISTS FOR (d:Domain) REQUIRE d.name IS UNIQUE;
CREATE CONSTRAINT group_object_id IF NOT EXISTS FOR (g:Group) REQUIRE (g.objectid) IS UNIQUE;
CREATE CONSTRAINT ou_name IF NOT EXISTS FOR (o:OU) REQUIRE (o.name) IS UNIQUE;
CREATE CONSTRAINT domain_object_id IF NOT EXISTS FOR (d:Domain) REQUIRE (d.objectid) IS UNIQUE;
CREATE CONSTRAINT ou_object_id IF NOT EXISTS FOR (o:OU) REQUIRE (o.objectid) IS UNIQUE;
CREATE CONSTRAINT user_name IF NOT EXISTS FOR (u:User) REQUIRE (u.name) IS UNIQUE;
CREATE CONSTRAINT computer_objectid IF NOT EXISTS FOR (c:Computer) REQUIRE (c.objectid) IS UNIQUE;
CREATE CONSTRAINT computer_name IF NOT EXISTS FOR (c:Computer) REQUIRE (c.name) IS UNIQUE;
CREATE CONSTRAINT user_objectid IF NOT EXISTS FOR (u:User) REQUIRE (u.objectid) IS UNIQUE;
CREATE CONSTRAINT gpo_name IF NOT EXISTS FOR (g:GPO) REQUIRE (g.name) IS UNIQUE;

//CREATE CONSTRAINT IF NOT EXISTS FOR (n:Group) REQUIRE n.neo4jImportId IS UNIQUE;
//CREATE CONSTRAINT IF NOT EXISTS FOR (n:HighValue) REQUIRE n.neo4jImportId IS UNIQUE;
//CREATE CONSTRAINT IF NOT EXISTS FOR (n:Domain) REQUIRE n.neo4jImportId IS UNIQUE;

// Import json data
CALL apoc.import.json("https://raw.githubusercontent.com/neo4j-graph-examples/cybersecurity/main/data/cybersecurity-json-data.json");
MATCH (n) WHERE n.highvalue SET n:HighValue;