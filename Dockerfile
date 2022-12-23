FROM golang:1.19.4
ARG prom_version
WORKDIR /tmp/build
RUN go mod init example.com/mod
RUN GOFLAGS="-mod=vendor -mod=readonly" go get -d -v github.com/prometheus/prometheus/cmd/promtool@v${prom_version}
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GO111MODULE=on go build -o /go/bin/promtool github.com/prometheus/prometheus/cmd/promtool

FROM alpine:3.17
COPY --from=0 /go/bin/promtool /bin
# ENTRYPOINT ["/bin/promtool"]
ENTRYPOINT [""]
