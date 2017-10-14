FROM nginx:1.12.1-alpine

COPY stub-universe.conf /etc/nginx/conf.d/default.conf

COPY universe.json /usr/share/nginx/html/universe.repo

COPY _artifacts/* /usr/share/nginx/html/

CMD cat /usr/share/nginx/html/elb.yaml; nginx -g 'daemon off;'