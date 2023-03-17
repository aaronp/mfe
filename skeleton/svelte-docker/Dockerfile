FROM node:19-alpine3.16 AS build

WORKDIR /app
COPY . .
RUN yarn
RUN yarn build

FROM nginx:1.23.3-alpine AS deploy-static

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]