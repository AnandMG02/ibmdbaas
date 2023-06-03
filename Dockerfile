# Use the official Flutter base image
FROM openjdk:8-jdk-alpine AS build

# Install Flutter SDK
RUN apk update && \
    apk add bash git unzip curl && \
    cd /usr/local/ && \
    git clone https://github.com/flutter/flutter.git && \
    export PATH=$PATH:/usr/local/flutter/bin && \
    flutter precache && \
    flutter doctor

# Install a specific Dart SDK version
RUN flutter config --enable-web

# Set the working directory
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock
COPY pubspec.yaml pubspec.lock ./

# Install dependencies
RUN flutter pub get

# Copy the entire project
COPY . .

# Build the Flutter web app
RUN flutter build web --release

# Use the NGINX base image
FROM nginx:stable-alpine

# Copy the built app from the previous stage
COPY --from=build /app/build/web/ /usr/share/nginx/html/

# Expose the NGINX port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
