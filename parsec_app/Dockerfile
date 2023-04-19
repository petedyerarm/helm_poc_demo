FROM rust:1.67.1-alpine as builder

RUN echo "-------- Multi Stage --------"

RUN echo "--------   Builder   --------"
WORKDIR /usr/src/app

RUN apk update \
    && apk add --no-cache libc-dev protoc bash

RUN export PROTOC="/usr/bin/protoc"; cargo install parsec-tool --version 0.5.2 --locked

FROM alpine as final_stage
RUN echo "-------- Final --------"

WORKDIR /usr/src/app

COPY ./parsec-test.sh .
RUN chmod 755 ./parsec-test.sh

COPY --from=builder /usr/local/cargo/bin/parsec-tool .
RUN chmod 755 ./parsec-tool

RUN apk update \
    && apk add --no-cache libc-dev bash

ENTRYPOINT ["/usr/src/app/parsec-test.sh"]

