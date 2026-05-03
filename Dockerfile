# ─── Stage 1: Build ───────────────────────────────────────────────────────────
# Use Node 20 LTS (current LTS as of 2024) as builder
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies first (leverages Docker layer cache)
COPY package*.json ./
RUN npm install

# Copy source and build the React app
COPY . .
RUN npm run build

# ─── Stage 2: Serve ───────────────────────────────────────────────────────────
# Use lightweight, production Nginx image to serve static files
FROM nginx:1.25-alpine

# Remove default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy built React app from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Copy custom Nginx config that handles React Router (client-side routing)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose HTTP port
EXPOSE 80

# Start Nginx in the foreground (required for Docker)
CMD ["nginx", "-g", "daemon off;"]
