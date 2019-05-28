FROM node:10-alpine as build

WORKDIR /build

COPY package.json yarn.lock /build/
RUN yarn

COPY index.js /build/

FROM node:10-alpine

WORKDIR /app/

COPY --from=build /build/ .

CMD node index.js
