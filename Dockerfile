# Use an official Flutter runtime as the base image
FROM cirrusci/flutter:stable

# Set the working directory inside the container
WORKDIR /app

# Copy the entire Flutter app directory into the container
COPY . /app

# Create a non-root user and switch to that user
RUN adduser --disabled-password --gecos '' appuser && \
    chown -R appuser:appuser /app
USER appuser

# Install Flutter dependencies
RUN flutter pub get

# Build the Flutter app for release
RUN flutter build apk --release

# Set the Flutter app as the entry point
ENTRYPOINT ["flutter", "run", "--release"]
