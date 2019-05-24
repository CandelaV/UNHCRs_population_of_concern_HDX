FROM neo4j

RUN wget -P /var/lib/neo4j/plugins/ https://github.com/neo4j-contrib/neo4j-graph-algorithms/releases/download/3.5.4.0/graph-algorithms-algo-3.5.4.0.jar && \
    wget -P /var/lib/neo4j/plugins/ https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.3/apoc-3.5.0.3-all.jar

ENV NEO4J_dbms_security_procedures_unrestricted=algo.\\\*
ENV NEO4J_dbms_security_procedures_unrestricted=apoc.\\\*
