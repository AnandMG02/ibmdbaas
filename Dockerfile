# Use the base Flutter image
FROM ghcr.io/cirruslabs/flutter:3.10.2

# Set the working directory inside the container
WORKDIR /app

# Copy the pubspec files to the container
COPY pubspec.* ./

# Install Flutter dependencies
RUN flutter pub get

# Copy the entire project directory to the container
COPY . .

# Build the Flutter web app
RUN flutter build web

# Set the command to serve the built web app
CMD [ "flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "8080"]
