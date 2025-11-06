# --- Stage 1: Build the React app ---
FROM node:18 AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Optional: API base URL for the frontend build
ARG VITE_API_BASE
ENV VITE_API_BASE=$VITE_API_BASE

# Copy the rest of the source
COPY . .

# Build the app
RUN npm run build

# --- Stage 2: Runtime (API + static) ---
FROM node:18-alpine

WORKDIR /app
ENV NODE_ENV=production
RUN apk add --no-cache python3 make g++ \
  && npm install -g serve

# Copy the build output and server
COPY --from=build /app/dist ./dist
COPY --from=build /app/server ./server
COPY package*.json ./
RUN npm ci --omit=dev

# Runtime configuration
ENV JWT_SECRET=change-me-in-prod
EXPOSE 5173 4000
CMD ["sh", "-c", "node server/index.js & serve -s dist -l 5173"]