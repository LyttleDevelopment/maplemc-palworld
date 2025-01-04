# Use the official NGINX image that includes the stream module
FROM nginx:latest

# Install gettext (for envsubst) and other necessary tools
RUN apt-get update && apt-get install -y gettext-base procps iproute2

# Copy the NGINX configuration template
COPY nginx.conf /etc/nginx/nginx.conf.template

# Expose the necessary port for UDP traffic
EXPOSE 8211/udp
EXPOSE 8211/tcp

# Optimize runtime settings
CMD /bin/bash -c "
    envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && \
    sysctl -w net.core.rmem_max=26214400 && \
    sysctl -w net.core.wmem_max=26214400 && \
    sysctl -w net.core.netdev_max_backlog=100000 && \
    nginx -g 'daemon off;'
"
