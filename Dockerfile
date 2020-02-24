FROM node:latest
LABEL key="Rafael Abrao"
COPY . /var/www
WORKDIR /var/www
RUN npm install
ENTRYPOINT [ "npm","start" ]
EXPOSE 3000


