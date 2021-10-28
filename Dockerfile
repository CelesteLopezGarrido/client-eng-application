#Primera Etapa
FROM node:14-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build --prod

#Segunda Etapa
FROM nginx:1.17.1-alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build-step /usr/src/app/dist/client-eng-application /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
