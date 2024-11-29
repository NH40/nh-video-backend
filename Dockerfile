# Base image
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Install dependencies first (caching)
COPY package*.json ./
COPY prisma ./prisma/

# Install dependencies including 'prisma' for the database
RUN npm install

# Copy app source
COPY . .

# Generate Prisma Client
RUN npx prisma generate

# Build application
RUN npm run build

# Expose the port the app runs on
EXPOSE 4200

# Start the server using production build
CMD [ "npm", "run", "prod" ]
