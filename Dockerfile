# Use lightweight nginx base
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy site files into nginx html directory
COPY . /usr/share/nginx/html/index.html
# If you have an images folder, copy it too
COPY . /usr/share/nginx/html/images

# Optional: expose port (nginx listens on 80 by default)
EXPOSE 80

# Start nginx (default command in official image already does this)
CMD ["nginx", "-g", "daemon off;"]

