FROM node:8

COPY index.js  /usr/src/app/index.js
COPY node_modules /usr/src/app/node_modules
WORKDIR /usr/src/app/
CMD node index.js