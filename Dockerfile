FROM alpine:3.4
RUN apk update && \
     apk add --no-cache openssl && \
     rm -rf /var/cache/apk/*
COPY cert_defaults.txt /src/cert_defaults.txt
RUN openssl req -x509 -nodes -out /src/cert.pem -keyout /src/cert.key -config /src/cert_defaults.txt

FROM nginx
COPY --from=0 /src/cert.* /etc/nginx/
COPY default.conf /etc/nginx/conf.d/
EXPOSE 443
