FROM node:alpine

# install simple http server for serving static content
RUN npm install -g http-server

WORKDIR /frontend

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 8080
ENTRYPOINT ["npm", "run", "serve"]
