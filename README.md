# crd-schema-gen
Containerized CRD validation generation

Based on a [fork](https://github.com/openshift/kubernetes-sigs-controller-tools) of functionality found in https://github.com/kubernetes-sigs/controller-tools/tree/master/cmd/crd

Looks at types found in currently available CRDs under a project's `manifests/` directory and traverses `openshift/api` types to find matching Golang structs, then generates OpenAPI validations for those CRDs

## Running

Build this image:
```
imagebuilder -f ./Dockerfile -t crd-schema-gen .
```

Then from your operator's repository run:

```
docker run -v $(pwd)/manifests:/go/src/github.com/openshift/crd-schema-gen/manifests:Z \
  -v $(pwd)/vendor/github.com/openshift/api:/go/src/github.com/openshift/crd-schema-gen/openshift/api:Z \
  -e APIS_DIR="openshift/api" crd-schema-gen
```

In this case we mount our local `manifests` directory where our CRDs reside and the local directory of our API definitions. Then pass the name of that location (relative to the crd-schema-gen GOPATH) to the container (`openshift/api`).