# Stage 1
FROM node:latest as build-step
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2 
FROM nginx:1.18.0-alpine as prod-stage
COPY --from=build-step /app/dist/angular-dashboard /usr/share/nginx/html
EXPOSE 80
CMD  ["nginx", "-g", "daemon off;"] 