FROM alpine:latest
RUN apk update

RUN apk add --no-cache nginx   

# nginx config
COPY nginx.conf /root/nginx.conf
RUN mkdir  -p /usr/share/doc/nginx/html

COPY index.html /usr/share/doc/nginx/html/index.html

# nginx port
EXPOSE 80

# starting nginx
CMD ["nginx", "-g", "daemon off;"]
