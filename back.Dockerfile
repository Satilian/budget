FROM golang:1.22

ENV GIN_MODE release

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY back/go.mod back/go.sum ./
RUN go mod download && go mod verify

COPY back .
RUN go build -v -o /usr/local/bin/app
EXPOSE 8080