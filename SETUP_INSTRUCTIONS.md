# Online Survey Platform - Complete Setup Instructions

## Overview

This document provides complete instructions for setting up the Online Survey Platform locally. The project is a full-stack web application with Django REST Framework backend, React frontend, PostgreSQL database, and Docker containerization.

## Quick Start (Recommended)

### Prerequisites

- Git
- Docker & Docker Compose
- Python 3.11+
- Node.js 18+
- PostgreSQL 15+

### Option 1: Automated Setup (Using Setup Script)

The repository includes a `SETUP_PROJECT.sh` script that generates the basic project structure.

```bash
# 1. Clone the repository
git clone https://github.com/balayyalegendmovie-spec/online-survey-platform.git
cd online-survey-platform

# 2. Make the setup script executable
chmod +x SETUP_PROJECT.sh

# 3. Run the setup script
./SETUP_PROJECT.sh
```

**Note**: The setup script creates the basic directory structure and some core files. You'll need to complete the implementation by adding all Django models, views, serializers, and React components as specified in the technical document.

### Option 2: Manual Setup

## Manual Project Setup

### Step 1: Backend Setup

#### 1.1 Create Django Project

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Create Django project
django-admin startproject config .

# Create Django apps
python manage.py startapp authentication
python manage.py startapp surveys  
python manage.py startapp questions
python manage.py startapp responses
python manage.py startapp analytics

# Move apps to apps directory
mkdir -p apps
mv authentication surveys questions responses analytics apps/
```

#### 1.2 Configure Django Settings

Edit `backend/config/settings.py` to include:

- Database configuration (PostgreSQL)
- REST Framework settings
- CORS settings
- JWT authentication
- Installed apps
- Static/Media file configuration

Refer to the technical specification document (paste.txt) for complete settings.

#### 1.3 Create Database Models

Implement the following models as per the specification:

- **User Model** (authentication/models.py)
- **Survey Model** (surveys/models.py)
- **Question Model** (questions/models.py)
- **QuestionOption Model** (questions/models.py)
- **Response Model** (responses/models.py)
- **Answer Model** (responses/models.py)

#### 1.4 Run Migrations

```bash
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
```

### Step 2: Frontend Setup

#### 2.1 Create React App with Vite

```bash
cd frontend
npm create vite@latest . -- --template react
npm install
```

#### 2.2 Install Dependencies

```bash
npm install axios react-router-dom recharts react-hot-toast tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

#### 2.3 Configure Tailwind CSS

Update `tailwind.config.js` and `src/index.css` as per specification.

#### 2.4 Create Project Structure

Create the following directory structure:

```
frontend/src/
├── components/
│   ├── common/
│   ├── layout/
│   ├── survey/
│   └── analytics/
├── pages/
│   ├── auth/
│   ├── dashboard/
│   ├── surveys/
│   └── public/
├── context/
├── hooks/
├── services/
├── utils/
└── routes/
```

### Step 3: Docker Setup

#### 3.1 Environment Variables

Copy `.env.example` to `.env` and update with your values:

```bash
cp .env.example .env
# Edit .env with your configuration
```

#### 3.2 Build and Run with Docker

```bash
# Build and start all services
docker-compose up --build

# Run migrations
docker-compose exec backend python manage.py migrate

# Create superuser
docker-compose exec backend python manage.py createsuperuser
```

### Step 4: Access the Application

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8000/api
- **Admin Panel**: http://localhost:8000/admin
- **API Documentation**: http://localhost:8000/api/docs

## Project Structure Reference

Refer to your technical specification document (paste.txt) for:

- Complete file structure
- All model definitions
- API endpoint specifications
- Component implementations
- Styling guidelines
- Testing strategy

## Development Workflow

### Running Tests

```bash
# Backend tests
cd backend
python manage.py test

# Frontend tests
cd frontend
npm test
```

### Code Quality

```bash
# Backend linting
flake8 backend/

# Frontend linting
npm run lint
```

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Ensure PostgreSQL is running
   - Check DATABASE_URL in .env
   
2. **Port Already in Use**
   - Change ports in docker-compose.yml
   
3. **Module Not Found**
   - Reinstall dependencies
   - Check virtual environment is activated

## Next Steps

After setup:

1. Implement all Django models, serializers, and views
2. Build React components for all pages
3. Integrate frontend with backend APIs
4. Add authentication flow
5. Implement survey creation and management
6. Add analytics and charting
7. Write tests
8. Deploy to production

## Resources

- [Technical Specification](./paste.txt)
- [Django Documentation](https://docs.djangoproject.com/)
- [React Documentation](https://react.dev/)
- [Docker Documentation](https://docs.docker.com/)

## Support

For issues or questions:
- Check the technical specification document
- Review error logs: `docker-compose logs`
- Ensure all environment variables are set correctly

---

**Estimated Development Time**: 9-11 weeks (2-3 months)

**Team Requirements**:
- 1 Backend Developer (Django)
- 1 Frontend Developer (React)
- 1 DevOps Engineer (part-time)
- 1 QA Engineer (part-time)
