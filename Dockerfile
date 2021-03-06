#Primera Etapa
FROM node:16.13.0 as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build

#Segunda Etapa
FROM nginxinc/nginx-unprivileged:latest
COPY --from=build-step /app/dist/client-eng-application /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
