FROM mongo:4.0.10
RUN apt-get update && apt-get install -y tcpdump curl iputils-ping
COPY ./initializer/initializeReplicaSet.js /opt/initializeReplicaSet.js
COPY ./initializer/initialize.sh /opt/initialize.sh
