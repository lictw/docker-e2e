FROM golang:1.10.2 AS builder

WORKDIR /
COPY . .
RUN go build -ldflags '-linkmode external -extldflags "-static"' main.go

FROM scratch
COPY --from=builder /main /web-application
COPY index.html /
CMD ["/web-application"]
