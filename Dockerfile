FROM node:latest AS build
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install --save --legacy-peer-deps
COPY . ./
RUN npm run build

### STAGE 2: Run ###

FROM nginx:1.17.1-alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]