# Use a slim Python 3.10 image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose port (Heroku assigns $PORT at runtime)
EXPOSE 5000

# Start the app using Gunicorn and Heroku POrt
CMD exec gunicorn --workers 4 --bind 0.0.0.0:$PORT app:app
