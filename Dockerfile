FROM crystallang/crystal:latest

ADD . /src
WORKDIR /src
RUN shards build --production --static

# busybox:glibc contains enough to allow a statically compiled 
FROM busybox:glibc
COPY --from=0 /src/bin/redis2ws /redis2ws
EXPOSE 3000
ENTRYPOINT ["/redis2ws"]
