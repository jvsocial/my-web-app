To create a complete Node.js project that serves a front-end and runs within a Docker container, I'll provide you with a simple Node.js + HTML setup. This includes Docker configuration, which will allow you to easily run the entire project inside a Docker container.

### Steps:

1. **Node.js Server** using built-in HTTP.
2. **Frontend** using plain HTML.
3. **Dockerfile** to containerize the application.

Here’s the directory structure of the project:

```
my-web-app/
│
├── index.html
├── server.js
├── Dockerfile
├── .dockerignore
└── package.json
```

### 1. `server.js` (Node.js HTTP Server)

```javascript
const http = require("http");
const fs = require("fs");
const path = require("path");

// Create HTTP server
const server = http.createServer((req, res) => {
  if (req.url === "/" || req.url === "/index.html") {
    const filePath = path.join(__dirname, "index.html");

    fs.readFile(filePath, "utf8", (err, data) => {
      if (err) {
        res.writeHead(500, { "Content-Type": "text/plain" });
        res.end("500 - Internal Server Error");
      } else {
        res.writeHead(200, { "Content-Type": "text/html" });
        res.end(data);
      }
    });
  } else {
    res.writeHead(404, { "Content-Type": "text/plain" });
    res.end("404 - Not Found");
  }
});

// Start server
const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
```

### 2. `index.html` (Front-end HTML)

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Web App</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        text-align: center;
        margin-top: 50px;
      }
    </style>
  </head>
  <body>
    <h1>Hello, I am a web app!</h1>
  </body>
</html>
```

### 3. `package.json` (Node.js Project Dependencies)

```json
{
  "name": "my-web-app",
  "version": "1.0.0",
  "description": "A simple Node.js web app",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {}
}
```

### 4. `Dockerfile` (Docker Configuration)

```Dockerfile
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
```

### 5. `.dockerignore` (Optional, to ignore unnecessary files)

```txt
node_modules
npm-debug.log
Dockerfile
.dockerignore
```

### 6. Build and Run the Docker Container

#### Step 1: Build the Docker Image

From the project directory (`my-web-app/`), run the following Docker command to build the image:

```bash
docker build -t my-web-app .
```

#### Step 2: Run the Docker Container

Run the following command to start a container from your image:

```bash
docker run -p 3000:3000 my-web-app
```

This will map port `3000` of your container to port `3000` of your host machine, allowing you to access the app at `http://localhost:3000`.

### Complete Setup

Now, the app will be running inside the Docker container, and when you visit `http://localhost:3000`, you will see the message **"Hello, I am a web app!"** displayed in your browser.
