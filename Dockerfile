FROM node:10-alpine as build

WORKDIR /build

COPY package.json yarn.lock /build/
COPY index.js /build/

RUN yarn

FROM node:10-alpine

WORKDIR /app/

COPY --from=build /build/ .

CMD node index.js
