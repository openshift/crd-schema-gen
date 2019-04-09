FROM registry.svc.ci.openshift.org/openshift/release:golang-1.10 AS builder
WORKDIR /go/src/github.com/openshift/crd-schema-gen
COPY . .
RUN go build -o crd-schema-gen cmd/crd-schema-gen/main.go
ENV APIS_DIR=vendor/github.com/openshift/api
ENTRYPOINT ./crd-schema-gen --apis-dir $APIS_DIR