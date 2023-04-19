FROM alpine:latest as builder

RUN apk add --no-cache python3

WORKDIR /usr/src/app

COPY ./led-app-sockets.sh ./edge-app.sh
COPY ./b.py .
COPY ./led_flash.py .
RUN chmod a+x ./led_flash.py

ENTRYPOINT ["/usr/src/app/edge-app.sh"]
