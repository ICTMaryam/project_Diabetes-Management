GenieSugar – Diabetes Management System

GenieSugar is a web-based Diabetes Management System designed to support patients, physicians, and caregivers in monitoring and managing diabetes effectively. The system enables secure user authentication, health data tracking, and role-based access, following best practices in modern web development and healthcare application security.

This project was developed as part of an academic ICT project and demonstrates full-stack application development, cloud deployment, and secure data handling.

 Key Features

User Authentication

Registration, login, logout

Secure password hashing

Session-based authentication

 Health Monitoring

Blood glucose logging

Food and activity tracking

Alerts for abnormal glucose levels

   Care Team Support

Physician and specialist association

Controlled access to patient data

 Data Management

PostgreSQL database integration

Schema-driven database design using Drizzle ORM

 Cloud Deployment

Backend hosted on Microsoft Azure App Service

Database hosted using managed PostgreSQL (Neon)

 Technologies Used
Frontend

React (TypeScript)

Vite

Tailwind CSS

Backend

Node.js

Express.js

TypeScript

Express-session

Database

PostgreSQL

Drizzle ORM

Cloud & Tools

Microsoft Azure App Service

Neon PostgreSQL

Git & GitHub

Visual Studio 2022

Environment Variables

Create a .env file in the project root with the following variables:

DATABASE_URL=postgresql://<username>:<password>@<host>/<database>
SESSION_SECRET=genie-sugar-secret
NODE_ENV=development
PORT=5000

Do not commit .env to GitHub

 Running the Project Locally
Install dependencies
npm install

 Run database migrations
npx drizzle-kit push

Start the backend server
npx tsx server/index.ts

Start the frontend
cd client
npm run dev


Backend runs on:

http://localhost:5000


Frontend runs on:

http://localhost:5173

  Azure Deployment

Backend deployed on Azure App Service (Node.js 20 LTS)

Environment variables configured in Azure App Service → Configuration

Continuous deployment via GitHub repository

   Security Considerations

Passwords are hashed before storage

No plaintext credentials are stored

Secure session handling using HTTP-only cookies

Environment variables used for secrets

This aligns with healthcare application security best practices.

  Academic Context

This project was developed as part of an academic requirement and demonstrates:

Full-stack web development

Secure authentication mechanisms

Cloud deployment using Microsoft Azure

Database schema design and migration

Professional software engineering practices

   Author

Maryam
ICT Student
GitHub: ICTMaryam
