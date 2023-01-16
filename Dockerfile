FROM ubuntu
RUN apt update && apt install nginx -y 
CMD ["nginx", "-g", "deamon off"]