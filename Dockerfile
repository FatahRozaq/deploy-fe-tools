# Gunakan image base untuk server statis
FROM node:20 AS build

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

# Tahap kedua: serve hasil build dengan image ringan
FROM nginx:stable-alpine

COPY --from=build /app/dist /usr/share/nginx/html

# Optional: ubah config Nginx untuk SPA (react-router)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
