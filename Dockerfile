# Use Node.js as the build stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy application files and build React app
COPY . .
RUN npm run build

# Use Nginx for serving the static files
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
