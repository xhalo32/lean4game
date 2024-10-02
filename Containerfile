FROM debian:bookworm AS lean4

RUN apt-get update && \
    apt-get install --yes --no-install-recommends git curl ca-certificates

RUN useradd -ms /bin/bash lean

USER lean

WORKDIR /home/lean

RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf -o elan-init.sh && \
    chmod +x elan-init.sh && \
    ./elan-init.sh -y -v && \
    . ~/.profile && \
    elan default stable && \
    elan --version && \
    lake --version && \
    lean --version


FROM node:22-bookworm AS lean4game-base

RUN apt-get update && \
    apt-get install --yes --no-install-recommends bubblewrap

RUN mkdir -p /usr/src/app && \
    chown -R node:node /usr/src/app

USER node

WORKDIR /usr/src/app

COPY --chown=node:node package* .

RUN npm ci

COPY --chown=node:node . .


FROM lean4game-base AS lean4game

COPY --from=lean4 --chown=node:node /home/lean/.elan /home/node/
COPY --from=lean4 --chown=node:node /home/lean/.profile /home/node/

RUN . ~/.profile && \
    npm run build

ENTRYPOINT ["sh", "/usr/src/app/entrypoint.sh"]
