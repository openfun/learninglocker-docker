# xapi-service Dockerfile
FROM node:10-jessie-slim as Builder

ARG VERSION

# Curl is required to download xapi-service tarball.
RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app

# Download release and extract it in /app
RUN cd /tmp && curl --compressed -L -o "xapi-service-${VERSION}.tar.gz" "https://github.com/LearningLocker/xapi-service/archive/${VERSION}.tar.gz" \
    && tar -xzf "xapi-service-${VERSION}.tar.gz" -C /app --strip-components 1 \
    && rm xapi-service-*.tar.gz

# Install xapi-service
RUN cd /app \
    && yarn install --ignore-engines \
    && yarn build

## New stage to create the release
FROM node:10-jessie-slim

RUN mkdir /app \
    && chown -R node. /app

USER node

WORKDIR /app

COPY --chown=node:node --from=Builder /app/package.json .
COPY --chown=node:node --from=Builder /app/yarn.lock .
RUN yarn install --production --ignore-engines
COPY --chown=node:node --from=Builder /app/dist/ dist/
RUN mkdir -p /app/storage

# Install PM2 process manager
ENV PATH="/home/node/.yarn/bin:$PATH"
RUN yarn global add pm2

CMD ["pm2-runtime", "dist/server.js"]
