# Use Python 3.10 slim image
FROM python:3.10-slim

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Ensure stdout/stderr are shown in logs
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy requirements first (better caching)
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy full application
COPY . .

# Heroku sets PORT dynamically
EXPOSE 5000

# Start app with Gunicorn (IMPORTANT)
CMD gunicorn app:app --bind 0.0.0.0:$PORT --workers 4