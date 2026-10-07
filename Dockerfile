FROM golang:1.22 AS builder

WORKDIR /app


COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /tracker

FROM alpine:3.20

WORKDIR /app

COPY --from=builder /tracker ./tracker
COPY tracker.db ./

CMD ["./tracker"]
