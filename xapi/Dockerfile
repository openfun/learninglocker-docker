# xapi-service Dockerfile
FROM node:8-jessie-slim as Builder

ARG VERSION="v2.2.15"

RUN mkdir /app

# Download release and extract it in /app
RUN cd /tmp && curl --compressed -L -o "xapi-service-${VERSION}.tar.gz" "https://github.com/LearningLocker/xapi-service/archive/${VERSION}.tar.gz" \
    && tar -xzf "xapi-service-${VERSION}.tar.gz" -C /app --strip-components 1 \
    && rm xapi-service-*.tar.gz

# Install xapi-service
RUN cd /app \
    && rm package-lock.json \
    && yarn install \
    && yarn build

## New stage to create the release
FROM node:8-jessie-slim

RUN mkdir /app \
    && chown -R node. /app

USER node

WORKDIR /app

COPY --chown=node:node --from=Builder /app/package.json .
COPY --chown=node:node --from=Builder /app/yarn.lock .
RUN yarn install --production
COPY --chown=node:node --from=Builder /app/dist/ dist/
RUN mkdir -p /app/storage

CMD ["yarn", "start"]
