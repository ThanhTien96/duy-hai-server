# FROM node:18
FROM oven/bun:1 as base

WORKDIR /usr/src/app

COPY . .

RUN bun install

EXPOSE 8080

CMD ["bun", "start"]
