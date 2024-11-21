FROM node:20.18.1-alpine3.19 AS base

RUN groupadd -r appgroup && useradd -r -g appgroup appuser
WORKDIR /usr/src/app

COPY ./src ./
COPY ./node_modules ./

RUN chown -R appuser:appgroup /usr/src/app

USER appuser

CMD ["node", "index.js"]