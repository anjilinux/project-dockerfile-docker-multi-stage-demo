FROM alpine:3.4
RUN apk update && \
     apk add --no-cache openssl && \
     rm -rf /var/cache/apk/*
COPY cert_defaults.txt /src/cert_defaults.txt
RUN openssl req -x509 -nodes -out /src/cert.pem -keyout /src/key.pem -config /src/cert_defaults.txt

FROM nginx
COPY --from=0 /src/*.pem /etc/nginx/
COPY default.conf /etc/nginx/conf.d/
EXPOSE 443