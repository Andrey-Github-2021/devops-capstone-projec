FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app

# Copy the application contents
COPY requirements.txt .

# Switch to a non-root user
RUN pip install --no-cache-dir -r requirements.txt
COPY service ./service
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the service
EXPOSE 8080
CMD ["gunicorn","--bind=0.0.0.0:8080", "--log-level=info", "service:app"]