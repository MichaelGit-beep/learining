


docker run -it --rm --name certbot \
-v ${PWD}:/letsencrypt \
-v ${PWD}/certs:/etc/letsencrypt \
certbot bash



docker run -it -d --name nginx \
-v ${PWD}/nginx.conf:/etc/nginx/nginx.conf \
-v ${PWD}:/letsencrypt \
-v ${PWD}/certs:/etc/letsencrypt \
-p 80:80 \
-p 443:443 \
nginx

# asdfasdf@gmail.com
# www.domain.com
# /letsencrypt