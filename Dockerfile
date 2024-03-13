FROM node:20-alpine3.18
USER root

#RUN apk --no-cache add redis
#RUN redis-server --version
#RUN redis-server --daemonize yes



RUN mkdir -p /home/node/app/node_modules && chown -R root:root /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

#USER node

RUN npm install

COPY --chown=root:root . .

EXPOSE 8080

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

#CMD ["entrypoint.sh"]
CMD [ "node", "server.js" ]
