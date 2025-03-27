
# Step 1: Build React app
FROM node:18 as build

WORKDIR /app/frontend
COPY package*.json ./
RUN npm install
COPY . .
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm run build

# Step 2: Serve using Nginx
FROM nginx:stable-alpine

# Copy build from previous stage
COPY --from=build /app/frontend/build /usr/share/nginx/html

# Replace default Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
