FROM golang:1.10.2 AS builder

WORKDIR /go/src/application
COPY . .
RUN go get . && go install -ldflags '-linkmode external -extldflags "-static"' 2> /dev/null

FROM scratch
COPY --from=builder /go/bin/application /web-application
COPY index.html /
CMD ["/web-application"]
