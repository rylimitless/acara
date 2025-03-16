FROM python:3.12-slim 

WORKDIR /app

COPY requirements.txt .

# Create and activate a virtual environment
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Install dependencies within the virtual environment
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy your application code
COPY . .

# Define the command to run your application
CMD ["python3", "your_app.py"]