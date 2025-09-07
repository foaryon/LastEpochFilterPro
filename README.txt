========================================
     EpochFilterPro v1.0
     AI-Powered Last Epoch Filter Creator
========================================

ABOUT
-----
EpochFilterPro is an advanced AI-powered loot filter generator for Last Epoch Season 3.
It uses cutting-edge AI technology (Groq/OpenAI) to create hyper-optimized filters
tailored to your specific build, corruption level, and playstyle.

FEATURES
--------
• 12 Pre-configured Season 3 Builds (all classes)
• AI-Enhanced Filter Generation (90-98% confidence)
• Corruption-Specific Optimization (0-1000+)
• 5 Strictness Levels (Regular to Giga Strict)
• Character Import & Analysis
• Dark Last Epoch Aesthetic UI
• Ultra-Fast Groq AI Integration

SYSTEM REQUIREMENTS
------------------
• Node.js v18 or higher
• 2GB RAM minimum
• Modern web browser (Chrome, Firefox, Edge)
• Internet connection (for AI features)

QUICK START
-----------
1. Extract all files to a folder
2. Run the installation script:
   - Windows: Double-click "install.bat"
   - Mac/Linux: Run "bash install.sh"
3. Add your API keys to the .env file
4. Start the server: npm run dev
5. Open http://localhost:5000 in your browser

API KEYS SETUP
--------------
The application requires API keys for AI features:

1. GROQ_API_KEY (Recommended - Ultra Fast)
   - Sign up at https://console.groq.com
   - Create a new API key
   - Add to .env file

2. OPENAI_API_KEY (Optional Fallback)
   - Sign up at https://platform.openai.com
   - Create a new API key
   - Add to .env file

FOLDER STRUCTURE
---------------
/client          - Frontend React application
/server          - Backend Node.js server
/shared          - Shared types and schemas
/attached_assets - Images and assets
package.json     - Dependencies
install.sh       - Linux/Mac installer
install.bat      - Windows installer

AVAILABLE BUILDS
---------------
• Sentinel: Forge Strike, Void Knight
• Primalist: Earthquake Werebear, Swarmblade
• Mage: Glacier Sorcerer, Lightning Blast
• Acolyte: Death Seal Lich, Wraith Lord
• Rogue: Umbral Blades, Flurry Marksman
• Sentinel: Warpath Void Knight, Shield Bash Forge Guard

RUNNING THE APPLICATION
----------------------
Development Mode:
  npm run dev

Production Mode:
  npm run build
  npm start

TROUBLESHOOTING
--------------
• Port Already in Use:
  Change PORT in .env file to another number (e.g., 3000)

• Installation Fails:
  1. Ensure Node.js v18+ is installed
  2. Delete node_modules folder and try again
  3. Run: npm cache clean --force

• AI Features Not Working:
  1. Check API keys in .env file
  2. Ensure internet connection
  3. Check console for error messages

• Database Issues:
  Application works without database (uses memory storage)
  For production, add PostgreSQL DATABASE_URL to .env

SUPPORT
-------
For issues or questions about Last Epoch filter generation,
refer to the in-app help or Last Epoch community resources.

CREDITS
-------
Built with React, Node.js, TypeScript, and AI technology.
Designed for the Last Epoch community.

========================================
           Enjoy EpochFilterPro!
========================================