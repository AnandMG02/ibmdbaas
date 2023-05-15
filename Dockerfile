# Use the nginx base image
FROM nginx:latest

# Copy the built Flutter web app files to the Nginx root directory
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
