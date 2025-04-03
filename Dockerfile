# Use Node.js as the base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy application files and build React app
COPY . .
RUN npm run build

# Set entrypoint for debugging
CMD ["echo", "React build complete"]
