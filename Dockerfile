# FROM node:16.8-alpine3.11 as builder

# ENV NODE_ENV build

# WORKDIR /home/node

# COPY . /home/node

# RUN npm ci \
#     && npm run build \
#     && npm prune --production

# # ---

# FROM node:16.8-alpine3.11

# ENV NODE_ENV production

# USER node
# WORKDIR /home/node

# COPY --from=builder /home/node/package*.json /home/node/
# COPY --from=builder /home/node/node_modules/ /home/node/node_modules/
# COPY --from=builder /home/node/dist/ /home/node/dist/

# EXPOSE 3000
# CMD ["node", "dist/main.js"]

# Using Node:10 Image Since it contains all 
# the necessary build tools required for dependencies with native build (node-gyp, python, gcc, g++, make)
# First Stage : to install and build dependences

FROM node:10 AS builder
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build


# Second Stage : Setup command to run your app using lightweight node image
FROM node:10-alpine
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["npm", "run", "start:prod"]