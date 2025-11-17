#!/bin/bash

# Online Survey Platform - Project Setup Script
# This script generates the complete project structure

echo "========================================"
echo "Online Survey Platform - Setup Script"
echo "========================================"
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Error: Not a git repository. Please run this from the cloned repository."
    exit 1
fi

echo "Creating project structure..."
echo ""

# Create backend directory structure
mkdir -p backend/config
mkdir -p backend/apps/authentication
mkdir -p backend/apps/surveys
mkdir -p backend/apps/questions
mkdir -p backend/apps/responses
mkdir -p backend/apps/analytics
mkdir -p backend/staticfiles
mkdir -p backend/media

# Create frontend directory structure
mkdir -p frontend/public
mkdir -p frontend/src/assets
mkdir -p frontend/src/components/common
mkdir -p frontend/src/components/layout
mkdir -p frontend/src/components/survey
mkdir -p frontend/src/components/analytics
mkdir -p frontend/src/pages/auth
mkdir -p frontend/src/pages/dashboard
mkdir -p frontend/src/pages/surveys
mkdir -p frontend/src/pages/public
mkdir -p frontend/src/context
mkdir -p frontend/src/hooks
mkdir -p frontend/src/services
mkdir -p frontend/src/utils
mkdir -p frontend/src/routes

echo "✓ Directory structure created"
echo ""
echo "Generating backend files..."

# Backend Dockerfile
cat > backend/Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    postgresql-client \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN python manage.py collectstatic --noinput || true

EXPOSE 8000

CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
EOF

echo "✓ Backend Dockerfile created"

# Backend manage.py
cat > backend/manage.py << 'EOF'
#!/usr/bin/env python
import os
import sys

if __name__ == '__main__':
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)
EOF

chmod +x backend/manage.py
echo "✓ manage.py created"

echo ""
echo "✓ Setup script created successfully!"
echo ""
echo "NEXT STEPS:"
echo "1. Run: chmod +x SETUP_PROJECT.sh"
echo "2. Run: ./SETUP_PROJECT.sh"
echo "3. Follow the instructions in SETUP_INSTRUCTIONS.md"
echo ""
echo "This will generate all backend and frontend files."
echo "========================================"
