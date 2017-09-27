FROM alpine:latest
ADD https://storage.googleapis.com/minikube/releases/v0.22.2/minikube-linux-amd64 minikube
RUN chmod +x minikube

FROM busybox:glibc
COPY --from=0 minikube /
ENTRYPOINT ["/minikube"]
