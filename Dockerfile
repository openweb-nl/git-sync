#openweb/git-sync:0.0.1
FROM golang:1.6-onbuild

VOLUME ["/git"]
ENV GIT_SYNC_DEST /git

COPY main.go /tmp
WORKDIR /tmp

ENTRYPOINT [ "go", "run", "./main.go" ] 