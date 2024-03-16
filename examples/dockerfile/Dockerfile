# This will create a docker image with nginx and copy the html folder to the container

# Use an official nginx image
FROM nginx:alpine

# Copy the html folder to the container
COPY ./html /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# To build the image, run the following command in the terminal:
# docker build -t nginx_image .

# To run the container, run the following command in the terminal:
# docker run -d -p 80:80 nginx_image

# You can now access the website by going to http://localhost:80 in your web browser.
