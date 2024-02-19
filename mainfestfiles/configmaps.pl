apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-configmap
data:
  nginx.conf: |
    events {
        worker_connections 1024;
    }

    http {
        index index.html index.htm;

        server {
            listen 80;

            root /usr/share/doc/nginx/html/; 

            location / {
            }
        }
    }