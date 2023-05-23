# Use the fischerscode/flutter image as the base
FROM fischerscode/flutter

# Set the working directory
WORKDIR /app

# Create a directory for pubspec files with read-only permissions
RUN mkdir -m 444 pubspec_files
COPY pubspec.yaml pubspec.lock ./pubspec_files/

# Change to pubspec_files directory
WORKDIR /app/pubspec_files

# Install dependencies
RUN flutter pub get

# Move back to the root directory
WORKDIR /app

# Copy the entire project
COPY . .

# Build the Flutter app for release
RUN flutter build apk --release

# Expose the desired port (if applicable)
EXPOSE 8080

# Run the Flutter app
CMD ["flutter", "run", "-d", "device"]
