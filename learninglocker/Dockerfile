# Learning Locker Dockerfile
FROM node:10-jessie-slim

# Change Learning Locker version to build, by providing the LL_VERSION build argument to
# to your build command
#
# $ docker build \
#   --build-arg LL_VERSION="v2.6.2" \
#   -t learninglocker:v2.6.2 \
#   .
#
ARG LL_VERSION

RUN mkdir /app \
    && chown node. /app

# Python, make and g++ are required in order to run node-gyp
# in the `yarn install` step.
# Curl is required to download learninglocker tarball.
RUN apt-get update \
    && apt-get install -y curl python make g++ \
    && rm -rf /var/lib/apt/lists/*

USER node

# Download release and extract it in /app
RUN cd /tmp && curl --compressed -L -o "learninglocker-${LL_VERSION}.tar.gz" "https://github.com/LearningLocker/learninglocker/archive/${LL_VERSION}.tar.gz" \
    && tar -xzf "learninglocker-${LL_VERSION}.tar.gz" -C /app --strip-components 1 \
    && rm learninglocker-*.tar.gz

# Install learning locker
# In a Docker context, LearningLocker's environment is injected in the container itself, so theoretically this file is not required.
# The .env file is only created to avoid application warning message.
RUN cd /app \
    && touch .env \
    && npm_config_build_from_source=true yarn install --ignore-engines \
    && yarn build-all

# Install PM2 node process manager
ENV PATH="/home/node/.yarn/bin:$PATH"
RUN yarn global add pm2

WORKDIR /app
