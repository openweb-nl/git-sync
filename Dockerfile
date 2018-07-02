#openweb/git-sync:0.0.2
FROM golang:1.9 as builder
WORKDIR /src
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o git-sync .

FROM alpine/git
RUN apk --no-cache add ca-certificates
WORKDIR /bin
COPY --from=builder /src/git-sync .
VOLUME ["/git"]
ENV GIT_SYNC_DEST /git
WORKDIR /usr/bin
ENTRYPOINT ["/bin/git-sync"]
