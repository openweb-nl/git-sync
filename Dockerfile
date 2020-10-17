FROM golang:1.6-onbuild

LABEL maintainer="Zobair Qauomi"
LABEL version="0.0.2"

VOLUME ["/git"]
ENV GIT_SYNC_DEST /git

COPY main.go /tmp
WORKDIR /tmp

ENTRYPOINT [ "go", "run", "./main.go" ] 