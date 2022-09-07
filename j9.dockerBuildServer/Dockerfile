FROM amazonlinux
RUN amazon-linux-extras install nginx1 -y
COPY ./nginx.conf /etc/nginx/nginx.conf
CMD ["nginx","-g","daemon off;"]