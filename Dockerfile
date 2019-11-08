FROM golang:latest AS builder
ADD . /opt/baas
WORKDIR /opt/baas
RUN go build cmd/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /opt/baas .
RUN chmod +x baas
ENTRYPOINT ["./baas"]
EXPOSE 8008
