
#podman network create sonarqube

# Doesn't work for Windows. 
# The VirtualBox shared folder is not writable by the 999:999 container user. 
# An another problem, initdb will try to create hard links and those will not work with VirtualBox shared folders.
#podman volume create vol-postgres-data -o type=bind -o device=/mnt/c/Users/Yuriy/Podman/FS/postgres-custom
#podman volume create vol-pgadmin-data -o type=bind -o device=/mnt/c/Users/Yuriy/Podman/FS/pgadmin-custom
#podman volume create vol-jenkins-data -o type=bind -o device=/mnt/c/Users/Yuriy/Podman/FS/jenkins-custom
#podman volume create vol-sonarqube-data -o type=bind -o device=/mnt/c/Users/Yuriy/Podman/FS/sonarqube-custom/data
#podman volume create vol-sonarqube-logs -o type=bind -o device=/mnt/c/Users/Yuriy/Podman/FS/sonarqube-custom/logs
#podman volume create vol-sonarqube-extensions -o type=bind -o device=/mnt/c/Users/Yuriy/Podman/FS/sonarqube-custom/extensions

#podman volume create vol-postgres-data
#podman volume create vol-pgadmin-data
#podman volume create vol-sonarqube-data
#podman volume create vol-sonarqube-logs
#podman volume create vol-sonarqube-extensions

(podman run
	-d
	--hostname postgres
	--name postgres
	--network sonarqube
	-v vol-postgres-data:/var/lib/postgresql/data
	postgres-custom)

(podman run
	-d
	--hostname pgadmin
	--name pgadmin
	--network sonarqube
	-v vol-pgadmin-data:/var/lib/pgadmin
	-p 5050:80
	pgadmin-custom)

(podman run
	-d
	--hostname sonarqube
	--name sonarqube
	--network sonarqube
	-v vol-sonarqube-data:/opt/sonarqube/data
	-v vol-sonarqube-logs:/opt/sonarqube/logs
	-v vol-sonarqube-extensions:/opt/sonarqube/extensions
	-p 9000:9000
	sonarqube-custom)

(podman run
	-d
	--hostname jenkins
	--name jenkins
	--network sonarqube
	-p 8080:8080
	-p 50000:50000
	-v vol-jenkins-data:/var/jenkins_home
	jenkins-custom)
