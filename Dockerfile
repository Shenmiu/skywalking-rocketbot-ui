FROM nginx:1.14-alpine

COPY ./dist/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./run.sh /usr/share/run.sh

RUN set -ex \
    && apk add --no-cache bash tzdata \
    && chmod +x /usr/share/run.sh

EXPOSE 80

ENTRYPOINT bash /usr/share/run.sh && nginx -g 'daemon off;' 