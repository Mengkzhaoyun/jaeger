# git

```bash
git remote add upstream git@github.com:jaegertracing/jaeger.git

git fetch upstream

git merge v1.21.0

git remote add beagle git@cloud.wodcloud.com:cloud/jaeger.git

git fetch beagle

git push beagle master
```

## build

```bash
go get -u github.com/mjibson/esc

rm -rf jaeger-ui
docker run --rm \
-v $PWD/:/go/src/github.com/jaegertracing/jaeger \
-w /go/src/github.com/jaegertracing/jaeger \
registry.cn-qingdao.aliyuncs.com/wod/jaeger-ui:v1.12.0 \
sh -c "mkdir -p jaeger-ui/packages/jaeger-ui/build && cp -r /opt/jaeger/www/* jaeger-ui/packages/jaeger-ui/build/"

export GOARCH=arm64
make build-all-in-one
```
