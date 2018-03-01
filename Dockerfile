FROM golang:1.9 as build

WORKDIR /go/src/github.com/Q2h1Cg/dnsbrute
COPY . .

RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o dnsbrute .

FROM golang:1.9.4-alpine3.7

ENV PATH=$PATH:/dict
VOLUME [ "/reports" ]
WORKDIR /reports

COPY --from=build /go/src/github.com/Q2h1Cg/dnsbrute/dnsbrute /usr/local/bin/dnsbrute
COPY dict /dict

ENTRYPOINT [ "/usr/local/bin/dnsbrute" ]
