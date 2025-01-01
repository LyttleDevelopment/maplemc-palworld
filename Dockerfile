# Use the official NGINX image that includes the stream module
FROM nginx:latest

# Install gettext (for envsubst)
RUN apt-get update && apt-get install -y gettext-base

# Copy the NGINX configuration template
COPY nginx.conf /etc/nginx/nginx.conf.template

# Expose only the necessary port
EXPOSE 24454

# At runtime, substitute environment variables into the NGINX config
CMD /bin/bash -c "envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"
