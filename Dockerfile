FROM node:lts-alpine AS base

# Install dependencies only when needed
FROM base AS deps

# Create app directory
WORKDIR /app

# Install dependencies
COPY upstream/backend/package.json upstream/backend/pnpm-lock.yaml* ./
ENV COREPACK_INTEGRITY_KEYS=0
RUN corepack enable pnpm && pnpm i --frozen-lockfile

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY ./upstream/backend/ .
COPY ./patch/* .

RUN apk add sed && sed -i 's/startServer();/export default startServer;/' main.ts

ENV COREPACK_INTEGRITY_KEYS=0
RUN corepack enable pnpm && pnpm run build

# Production image, copy all the files and run node
FROM base AS runner

ENV NODE_ENV production
ENV ENVPATH ./dist/app/token.env
USER node

# Create app directory
WORKDIR /app

COPY --from=deps --chown=node:node /app/node_modules ./node_modules
COPY --from=builder --chown=node:node /app/dist ./dist

EXPOSE 8080
CMD [ "node", "dist/app/premain.js" ]
