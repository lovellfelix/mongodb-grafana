FROM node:lts-alpine AS builder

WORKDIR /app
COPY . .
RUN npm install 
RUN npm run build

FROM node:lts-alpine as runtime

WORKDIR /app
COPY dist/server /app
COPY --from=builder "./app/dist/server/" "./app/"
COPY package.json /app

RUN npm install --production

VOLUME /app/config
EXPOSE 3333

CMD node mongodb-proxy.js