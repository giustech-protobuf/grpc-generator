FROM golang:1.19

RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install protobuf-compiler -y
RUN go env -w GO111MODULE=off
RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
RUN go get google.golang.org/protobuf/cmd/protoc-gen-go

RUN wget https://github.com/ktr0731/evans/releases/download/0.9.1/evans_linux_amd64.tar.gz
RUN tar -xzvf evans_linux_amd64.tar.gz
RUN mv evans ../bin
RUN rm -f evans_linux_amd64.tar.gz

