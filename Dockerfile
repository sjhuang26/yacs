FROM nginx:1.11.9-alpine

MAINTAINER Mark Robinson <robinm8@rpi.edu>

RUN rm /etc/nginx/nginx.conf && \
    rm /etc/nginx/conf.d/default.conf

RUN mkdir /etc/nginx/cache

COPY ./ /etc/nginx/
