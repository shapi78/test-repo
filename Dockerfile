FROM nginx:latest
ENV MASSAGE=hi
cmd echo $MASSAGE > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'
