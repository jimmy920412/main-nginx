# Use the official Nginx image as the base image
FROM nginx:latest

# Install Certbot
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx

# Copy the custom Nginx configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy and set entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start Nginx and Certbot renewal when the container is launched
CMD ["/entrypoint.sh"]
