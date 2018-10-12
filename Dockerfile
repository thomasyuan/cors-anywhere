FROM node:alpine as builder

WORKDIR cors-anywhere
COPY . .
RUN npm install --only=production


FROM node:alpine

RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR cors-anywhere
COPY --from=builder /cors-anywhere .

RUN chown node.node /cors-anywhere
USER node
CMD ["node", "server.js"]
