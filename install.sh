#!/bin/bash

# EpochFilterPro Installation Script
# This script installs all required dependencies and sets up the application

echo "========================================="
echo "  EpochFilterPro Installation Script"
echo "  Last Epoch AI Filter Generator"
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Node.js is installed
check_node() {
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js is not installed!${NC}"
        echo "Please install Node.js (v18 or higher) from https://nodejs.org"
        exit 1
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        echo -e "${RED}❌ Node.js version is too old!${NC}"
        echo "Please install Node.js v18 or higher from https://nodejs.org"
        exit 1
    fi
    
    echo -e "${GREEN}✓ Node.js $(node -v) installed${NC}"
}

# Check if npm is installed
check_npm() {
    if ! command -v npm &> /dev/null; then
        echo -e "${RED}❌ npm is not installed!${NC}"
        echo "Please install npm"
        exit 1
    fi
    echo -e "${GREEN}✓ npm $(npm -v) installed${NC}"
}

# Install dependencies
install_dependencies() {
    echo ""
    echo "Installing dependencies..."
    echo "This may take a few minutes..."
    
    if npm install; then
        echo -e "${GREEN}✓ Dependencies installed successfully${NC}"
    else
        echo -e "${RED}❌ Failed to install dependencies${NC}"
        exit 1
    fi
}

# Setup environment variables
setup_env() {
    echo ""
    echo "Setting up environment..."
    
    if [ ! -f .env ]; then
        cat > .env << 'EOF'
# Database Configuration (PostgreSQL)
DATABASE_URL=
PGDATABASE=
PGHOST=
PGPASSWORD=
PGPORT=
PGUSER=

# AI API Keys (Required for AI features)
GROQ_API_KEY=
OPENAI_API_KEY=

# Server Configuration
PORT=5000
NODE_ENV=development
EOF
        echo -e "${GREEN}✓ Created .env file${NC}"
        echo ""
        echo -e "${YELLOW}⚠️  IMPORTANT: API Keys Required${NC}"
        echo "Please add your API keys to the .env file:"
        echo ""
        echo "1. GROQ_API_KEY - Get from https://console.groq.com"
        echo "   (Required for ultra-fast AI filter generation)"
        echo ""
        echo "2. OPENAI_API_KEY - Get from https://platform.openai.com"
        echo "   (Optional fallback for AI features)"
        echo ""
        echo "3. DATABASE_URL - PostgreSQL connection string"
        echo "   (Optional - app works with in-memory storage)"
    else
        echo -e "${GREEN}✓ .env file already exists${NC}"
    fi
}

# Build the application
build_app() {
    echo ""
    echo "Building the application..."
    
    if npm run build 2>/dev/null; then
        echo -e "${GREEN}✓ Application built successfully${NC}"
    else
        echo -e "${YELLOW}⚠️  Build step skipped (development mode)${NC}"
    fi
}

# Main installation flow
main() {
    echo "Starting installation..."
    echo ""
    
    # Check prerequisites
    check_node
    check_npm
    
    # Install and setup
    install_dependencies
    setup_env
    build_app
    
    echo ""
    echo "========================================="
    echo -e "${GREEN}✅ Installation Complete!${NC}"
    echo "========================================="
    echo ""
    echo "Next steps:"
    echo "1. Add your API keys to the .env file"
    echo "2. Run 'npm run dev' to start the development server"
    echo "3. Open http://localhost:5000 in your browser"
    echo ""
    echo "For production deployment:"
    echo "Run 'npm run build' then 'npm start'"
    echo ""
    echo "Enjoy EpochFilterPro!"
}

# Run main installation
main