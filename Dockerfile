FROM alpine:latest

ADD https://storage.googleapis.com/kubernetes-release/release/v1.7.5/bin/linux/amd64/kubectl kubectl
RUN chmod +x kubectl

ADD https://storage.googleapis.com/minikube/releases/v0.22.2/minikube-linux-amd64 minikube
RUN chmod +x minikube

ADD https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz docker-17.09.0-ce.tgz
RUN tar xzvf docker-17.09.0-ce.tgz

FROM debian:stable-slim

COPY --from=0 kubectl minikube docker/docker /usr/local/bin/

RUN apt-get update && apt-get install -y \
    sudo \
    psmisc \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/minikube"]
