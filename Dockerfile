# Use an official Node.js runtime as a parent image
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run the app when the container starts
CMD [ "npm", "start" ]
