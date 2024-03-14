FROM node:20-alpine3.18
USER root

RUN mkdir -p /home/node/app/node_modules && chown -R root:root /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

RUN npm install

COPY --chown=root:root . .

EXPOSE 8080

CMD [ "node", "server.js" ]
