#!/bin/bash

# FreeRDP GUI Build Script for Linux
# This script builds a standalone executable using PyInstaller

set -e

echo "=========================================="
echo "FreeRDP GUI Build Script"
echo "=========================================="

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 is not installed"
    echo "Please install Python3 first"
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "Error: pip3 is not installed"
    echo "Please install pip3 first"
    exit 1
fi

# Install required packages
echo "Installing required packages..."
pip3 install -r requirements.txt

# Check if PyInstaller is installed
if ! command -v pyinstaller &> /dev/null; then
    echo "Installing PyInstaller..."
    pip3 install pyinstaller
fi

# Create the executable
echo "Building executable with PyInstaller..."
pyinstaller --onefile --windowed --name "FreeRDP-GUI" \
    freerdp_gui.py

# Check if build was successful
if [ -f "dist/FreeRDP-GUI" ]; then
    echo "=========================================="
    echo "Build successful!"
    echo "Executable location: dist/FreeRDP-GUI"
    echo "=========================================="
    
    # Make the executable executable
    chmod +x dist/FreeRDP-GUI
    
    echo ""
    echo "To run the application:"
    echo "  ./dist/FreeRDP-GUI"
    echo ""
    echo "To install system-wide (optional):"
    echo "  sudo cp dist/FreeRDP-GUI /usr/local/bin/"
    echo "  sudo chmod +x /usr/local/bin/FreeRDP-GUI"
    echo ""
else
    echo "=========================================="
    echo "Build failed!"
    echo "Please check the error messages above"
    echo "=========================================="
    exit 1
fi
