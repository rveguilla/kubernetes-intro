FROM node:8 as builder

WORKDIR /build/app

COPY package.json yarn.lock ./
RUN yarn
COPY index.js .
RUN yarn test
RUN yarn --prod
RUN rm package.json yarn.lock

FROM node:8

COPY --from=builder /build/app /app

WORKDIR /app
CMD node index.js
