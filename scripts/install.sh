#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

PROJECT=gabrielkoo/q-dependabot

REPO_URL="https://github.com/$PROJECT"
REPO_RAW_URL="https://raw.githubusercontent.com/$PROJECT/main"

echo -e "${BLUE}=== q-dependabot Installer ===${NC}"

# Check for required dependencies
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}Error: $1 is required but not installed.${NC}"
        echo -e "${YELLOW}Please install $1 and try again.${NC}"
        exit 1
    fi
}

echo -e "${YELLOW}Checking dependencies...${NC}"
check_dependency "q"
check_dependency "gh"
check_dependency "git"
check_dependency "curl"
check_dependency "jq"

# Configuration directory
CONFIG_DIR="$HOME/.qdependabot"
RULES_DIR="$CONFIG_DIR/rules"
REPO_DIR="/tmp/q-dependabot-install-$$"
INSTALL_DIR="/usr/local/bin"
CONFIG_FILE="$CONFIG_DIR/config.json"

# Create config directory
echo -e "${YELLOW}Creating configuration directory...${NC}"
mkdir -p "$CONFIG_DIR"
mkdir -p "$RULES_DIR"
mkdir -p "$REPO_DIR"

# Clone the repository
echo -e "${YELLOW}Cloning repository to temporary directory...${NC}"
git clone "$REPO_URL" "$REPO_DIR" 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to clone repository. Please check your internet connection and try again.${NC}"
    exit 1
else
    # Copy rules files
    echo -e "${YELLOW}Setting up rules...${NC}"
    cp "$REPO_DIR/.amazonq/rules/"*.md "$RULES_DIR/"

    # Copy config example
    if [ -f "$REPO_DIR/config.json" ]; then
        cp "$REPO_DIR/config.json" "$CONFIG_FILE.example"
    fi
fi

# Create default config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${YELLOW}Creating default configuration...${NC}"
    if [ -f "$CONFIG_FILE.example" ]; then
        cp "$CONFIG_FILE.example" "$CONFIG_FILE"
    else
        # Create a basic config if example is not available
        echo '{
  "dependent-repositories": [
    {
      "path": "'"$HOME/projects/myrepo"'",
      "manifests": ["requirements.txt", "Dockerfile", "package.json"]
    }
  ],
  "monitored-projects": [
    "boto/boto3",
    "aws-samples/aws-cdk-examples"
  ]
}' > "$CONFIG_FILE"
    fi
    echo -e "${GREEN}Default configuration created at $CONFIG_FILE${NC}"
    echo -e "${YELLOW}Please edit this file to add your repositories and monitored projects.${NC}"
fi

# Copy executable
echo -e "${YELLOW}Installing q-dependabot executable...${NC}"
echo -e "${YELLOW}Note: This step requires sudo privileges to install to $INSTALL_DIR/${NC}"
if [ -f "$REPO_DIR/scripts/q-dependabot" ]; then
    chmod +x "$REPO_DIR/scripts/q-dependabot"
    sudo cp "$REPO_DIR/scripts/q-dependabot" "$INSTALL_DIR/"
elif [ -f "$REPO_DIR/q-dependabot" ]; then
    chmod +x "$REPO_DIR/q-dependabot"
    sudo cp "$REPO_DIR/q-dependabot" "$INSTALL_DIR/"
else
    echo -e "${RED}Error: q-dependabot executable not found.${NC}"
    echo -e "${YELLOW}Cleaning up temporary files...${NC}"
    rm -rf "$REPO_DIR"
    exit 1
fi

# Check if installation was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to install executable. Please check permissions and try again.${NC}"
    echo -e "${YELLOW}You may need to run this script with sudo.${NC}"
    echo -e "${YELLOW}Cleaning up temporary files...${NC}"
    rm -rf "$REPO_DIR"
    exit 1
fi

# Create a persistent repo clone for updates
echo -e "${YELLOW}Creating persistent repository clone for updates...${NC}"
REPO_CLONE_DIR="$CONFIG_DIR/repo"
rm -rf "$REPO_CLONE_DIR"
git clone "$REPO_URL" "$REPO_CLONE_DIR" 2>/dev/null

# Cleanup temporary repository
echo -e "${YELLOW}Cleaning up temporary files...${NC}"
rm -rf "$REPO_DIR"

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}You can now run q-dependabot from anywhere.${NC}"
echo -e "${YELLOW}To configure your monitored repositories and projects, run:${NC}"
echo -e "  q-dependabot config"
echo ""
echo -e "${BLUE}Available commands:${NC}"
q-dependabot help

exit 0
