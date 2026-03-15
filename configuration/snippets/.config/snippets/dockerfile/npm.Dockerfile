# Stage: Base
FROM node:24-alpine AS base
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./

# Stage: Builder
FROM base AS builder
RUN npm ci
COPY . .
RUN npm run lint
# [Typescript] Transpile
RUN npm run build

# Stage: devenv
FROM builder AS devenv
ENV NODE_ENV=development
# [Tools] Install dev/debugging tools
USER root
RUN apk add --no-cache bash git curl vim jq bat glow
USER node

# Stage: runner
FROM base AS runner
ENV NODE_ENV=production
RUN npm ci --omit=dev && npm cache clean --force
# [Typescript] Copy transpiled
COPY --from=builder /app/dist ./dist
# [ES6 modules] Copy
COPY --from=builder /app/src ./src

USER node
# EXPOSE 3000
CMD ["node", "dist/index.js"]
