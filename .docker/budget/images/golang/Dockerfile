FROM golang:alpine
ARG WORKDIR=/app
VOLUME ${WORKDIR}
WORKDIR ${WORKDIR}
RUN cd ${WORKDIR}
RUN go install github.com/cosmtrek/air@latest
RUN air init
EXPOSE 8080