FROM node:8

WORKDIR /usr/src/app/
COPY node_modules /usr/src/app/node_modules
COPY index.js  /usr/src/app/index.js
CMD node index.js
