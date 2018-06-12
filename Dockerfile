FROM plugins/base:amd64

LABEL maintainer="Drone.IO Community <drone-dev@googlegroups.com>" \
  org.label-schema.name="Drone Hugo" \
  org.label-schema.vendor="Drone.IO Community" \
  org.label-schema.schema-version="1.0"

ARG HUGO_VERSION
ARG HUGO_ARCH
ENV PLUGIN_HUGO_ARCH=$HUGO_ARCH
ENV PLUGIN_HUGO_SHIPPED_VERSION=$HUGO_VERSION

ADD release/linux/amd64/drone-hugo /bin/
RUN apk update && \
    apk --no-cache add git && \
    chmod +x bin/drone-hugo && \
    mkdir /temp/ && \
    wget -O- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-${HUGO_ARCH}.tar.gz | tar xz -C /temp/ && \
    mv /temp/hugo /bin/hugo && \
    rm  -rf /temp

ENTRYPOINT ["/bin/drone-hugo"]
