
CREATE USER sonarqube WITH PASSWORD 'sonardbpass';

CREATE DATABASE sonarqubedb;

ALTER DATABASE sonarqubedb OWNER TO sonarqube;
