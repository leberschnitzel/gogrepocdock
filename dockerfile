# Use the base Python image
FROM python:3.9.22-alpine

#Install wget to pull the latest version of gogrepoc.py
RUN pip install --upgrade pip
RUN apk add --no-cache wget
RUN apk add gcc musl-dev linux-headers

# Install necessary Python packages
RUN pip install html5lib html2text requests pyOpenSSL psutil


# Create directories for the application and downloads
RUN mkdir -p /gogrepocdock/downloads

# Copy the entry-point script into the container
COPY entrypoint.sh /gogrepocdock

# Make the entry-point script executable
RUN chmod +x /gogrepocdock/entrypoint.sh

# Set the working directory
WORKDIR /gogrepocdock

# Set the entry-point script as the entry point for the Docker container
ENTRYPOINT ["./entrypoint.sh"]
