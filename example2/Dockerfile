# Use an official Python runtime as a parent image
FROM python:2.7-slim

# Use pip to install dependencies
RUN pip install --trusted-host pypi.python.org redis flask

# Set the working directory to /app
WORKDIR /app

# Copy the example source directory contents into the container at /app
COPY ./src /app


# Set environment variable pointing to container-local libraries
ENV PYTHONPATH /app

EXPOSE 8081

# Run app.py when the container launches
CMD ["python", "app.py"]
