FROM registry.cn-qingdao.aliyuncs.com/wod/golang-arm64:1.14.6-alpine as golang

WORKDIR /go/src/github.com/jaegertracing/jaeger

Add . ./

ARG VERSION=v1.22.1

ENV GOPROXY=https://goproxy.cn,direct

RUN go build -o /go/bin/all-in-one -ldflags "-X main.version=${VERSION}" /go/src/github.com/jaegertracing/jaeger/cmd/all-in-one

FROM registry.cn-qingdao.aliyuncs.com/wod/alpine-arm64:3.12

COPY --from=golang /go/bin/all-in-one /go/bin/all-in-one

# Agent zipkin.thrift compact
EXPOSE 5775/udp

# Agent jaeger.thrift compact
EXPOSE 6831/udp

# Agent jaeger.thrift binary
EXPOSE 6832/udp

# Agent config HTTP
EXPOSE 5778

# Collector HTTP
EXPOSE 14268

# Collector gRPC
EXPOSE 14250

# Web HTTP
EXPOSE 16686

COPY --from=golang /go/bin/all-in-one /opt/jaeger/all-in-one
COPY ./cmd/all-in-one/sampling_strategies.json /etc/jaeger/
COPY ./jaeger-ui/packages/jaeger-ui/build /opt/jaeger/www

VOLUME ["/tmp"]
ENTRYPOINT ["/opt/jaeger/all-in-one"]
CMD ["--sampling.strategies-file=/etc/jaeger/sampling_strategies.json","--query.static-files=/opt/jaeger/www"]
