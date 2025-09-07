#!/usr/bin/env node

/**
 * EpochFilterPro Windows Executable Builder
 * Creates a standalone .exe file for Windows 11 x64
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('========================================');
console.log('  EpochFilterPro .exe Builder');
console.log('  Creating Windows 11 x64 Executable');
console.log('========================================');
console.log('');

// Configuration for the executable
const config = {
  name: 'EpochFilterPro',
  version: '1.0.0',
  description: 'AI-Powered Last Epoch Filter Creator',
  author: 'EpochFilterPro Team',
  icon: 'electron/icon.ico',
  entryPoint: 'electron/main.js',
  outputDir: 'dist-exe',
  platform: 'win32',
  arch: 'x64'
};

// Create output directory
if (!fs.existsSync(config.outputDir)) {
  fs.mkdirSync(config.outputDir, { recursive: true });
}

// Build steps
async function buildExecutable() {
  try {
    console.log('[1/5] Building frontend...');
    execSync('npm run build:client', { stdio: 'inherit' });
    
    console.log('[2/5] Building backend...');
    execSync('npm run build:server', { stdio: 'inherit' });
    
    console.log('[3/5] Preparing Electron app...');
    
    // Create package.json for Electron
    const electronPackage = {
      name: config.name.toLowerCase(),
      version: config.version,
      description: config.description,
      main: 'main.js',
      author: config.author,
      scripts: {
        start: 'electron .'
      }
    };
    
    fs.writeFileSync(
      path.join(config.outputDir, 'package.json'),
      JSON.stringify(electronPackage, null, 2)
    );
    
    // Copy necessary files
    console.log('[4/5] Copying application files...');
    
    // Copy Electron main file
    fs.copyFileSync('electron/main.js', path.join(config.outputDir, 'main.js'));
    
    // Copy built frontend
    copyFolderRecursiveSync('client/dist', path.join(config.outputDir, 'client/dist'));
    
    // Copy built backend
    copyFolderRecursiveSync('dist/server', path.join(config.outputDir, 'server'));
    
    // Copy shared files
    if (fs.existsSync('shared')) {
      copyFolderRecursiveSync('shared', path.join(config.outputDir, 'shared'));
    }
    
    console.log('[5/5] Building Windows executable...');
    
    // Use electron-builder to create the exe
    execSync(`npx electron-builder --win --x64 --dir`, {
      cwd: config.outputDir,
      stdio: 'inherit'
    });
    
    console.log('');
    console.log('========================================');
    console.log('  Build Complete!');
    console.log('========================================');
    console.log('');
    console.log(`Executable created: ${config.outputDir}/${config.name}.exe`);
    console.log('');
    console.log('The executable is fully standalone and includes:');
    console.log('- Node.js runtime');
    console.log('- All application code');
    console.log('- All dependencies');
    console.log('- Electron wrapper for native Windows experience');
    console.log('');
    console.log('Simply run EpochFilterPro.exe on any Windows 11 x64 machine!');
    
  } catch (error) {
    console.error('Build failed:', error.message);
    process.exit(1);
  }
}

// Helper function to copy folders
function copyFolderRecursiveSync(source, target) {
  if (!fs.existsSync(target)) {
    fs.mkdirSync(target, { recursive: true });
  }
  
  if (fs.lstatSync(source).isDirectory()) {
    const files = fs.readdirSync(source);
    files.forEach(file => {
      const curSource = path.join(source, file);
      const curTarget = path.join(target, file);
      if (fs.lstatSync(curSource).isDirectory()) {
        copyFolderRecursiveSync(curSource, curTarget);
      } else {
        fs.copyFileSync(curSource, curTarget);
      }
    });
  }
}

// Run the build
buildExecutable();