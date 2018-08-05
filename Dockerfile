FROM crystallang/crystal:latest

ADD . .
RUN shards build --production --static

# busybox:glibc contains enough to allow a statically compiled crystal binary to run
FROM busybox:glibc
COPY --from=0 /bin /app
COPY --from=0 /public /app/public
EXPOSE 3000
ENTRYPOINT ["/app/redis2ws"]
