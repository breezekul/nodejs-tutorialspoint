# Stage 1
FROM node:22-alpine3.18 as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Stage 2: Production (slim and optimized)
FROM node:18-alpine

# Copy only the production-ready application files from the build stage
COPY --from=build /app /app

WORKDIR /app

# Expose port
EXPOSE 8081

# Command to run the application
CMD ["node", "server.js"]