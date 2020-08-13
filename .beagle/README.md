# build

```bash
docker buildx build \
  --tag registry.cn-qingdao.aliyuncs.com/wod/jaegertracing-arm64:v1.18.1 \
  --platform linux/arm64 \
  --file .beagle/arm.dockerfile .
```
