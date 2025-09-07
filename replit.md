# Overview

This is a full-stack web application built for Last Epoch players to generate optimized loot filters using AI. The application analyzes Season 3 builds and creates XML loot filter files tailored to specific corruption levels and character builds. The system combines expert game knowledge with AI-powered optimization to help players efficiently acquire the best gear for their builds.

# User Preferences

Preferred communication style: Simple, everyday language.

# System Architecture

## Frontend Architecture
- **Framework**: React 18 with TypeScript running on Vite for fast development and building
- **UI Components**: Comprehensive design system using shadcn/ui with Radix UI primitives and Tailwind CSS
- **Routing**: Wouter for lightweight client-side routing
- **State Management**: TanStack Query for server state management with optimistic updates and caching
- **Styling**: Tailwind CSS with custom CSS variables for theming and responsive design

## Backend Architecture
- **Runtime**: Node.js with Express.js API server
- **Database ORM**: Drizzle ORM with PostgreSQL for type-safe database operations
- **Database Provider**: Neon serverless PostgreSQL for scalable cloud database hosting
- **AI Integration**: OpenAI GPT-5 for intelligent filter generation and build analysis
- **Session Management**: Express sessions with PostgreSQL session store for user state

## Core Domain Logic
- **Build Analysis Engine**: Comprehensive Season 3 build database with tier ratings, affix priorities, and defense requirements
- **Filter Generation Service**: AI-powered system that creates XML loot filters based on build requirements, corruption levels, and strictness preferences
- **Corruption Calculator**: Game mechanics calculator for damage scaling and tier progression analysis

## Data Storage Solutions
- **Primary Database**: PostgreSQL with tables for builds, generated filters, AI analysis results, and user data
- **Development Fallback**: In-memory storage implementation for development and testing environments
- **Session Storage**: PostgreSQL-backed session store for user authentication and preferences

## Authentication and Authorization
- **Session-based Authentication**: Express sessions with secure cookie management
- **User Management**: User accounts with build preferences and filter history
- **Development Mode**: Simplified authentication flow for development environment

# External Dependencies

## Database Services
- **Neon Database**: Serverless PostgreSQL hosting with connection pooling and automatic scaling
- **Drizzle Kit**: Database migration and schema management tools

## AI and Machine Learning
- **OpenAI API**: GPT-5 model for intelligent filter generation, build analysis, and recommendations
- **AI Filter Service**: Custom service layer for game-specific AI prompting and response processing

## UI and Design System
- **shadcn/ui**: Pre-built accessible UI components built on Radix UI primitives
- **Radix UI**: Headless UI components for accessibility and customization
- **Tailwind CSS**: Utility-first CSS framework with custom design tokens
- **Lucide React**: Consistent icon library for the entire application

## Development and Build Tools
- **Vite**: Fast build tool and development server with Hot Module Replacement
- **TypeScript**: Type safety across the entire application stack
- **ESBuild**: Fast JavaScript bundler for production builds
- **PostCSS**: CSS processing with Tailwind CSS integration

## Game-Specific Integrations
- **Last Epoch Build Database**: Curated Season 3 build data with expert analysis and tier rankings
- **XML Filter Generation**: Custom XML generation for Last Epoch's loot filter system
- **Corruption Mechanics**: Game-accurate corruption scaling calculations and tier progression logic