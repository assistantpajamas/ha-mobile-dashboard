#!/bin/bash

# Install Home Assistant Mobile Dashboard
# This script helps install the mobile dashboard to your Home Assistant instance

echo "Home Assistant Mobile Dashboard Installer"
echo "----------------------------------------"

# Check if config directory is provided
if [ -z "$1" ]; then
  echo "Please provide your Home Assistant config directory path."
  echo "Usage: ./install.sh /path/to/homeassistant/config"
  exit 1
fi

CONFIG_DIR=$1
DASHBOARD_FILE="$CONFIG_DIR/dashboard.yaml"

# Check if config directory exists
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Error: The specified directory does not exist."
  exit 1
fi

# Download the dashboard file
echo "Copying dashboard.yaml to $DASHBOARD_FILE"
cp dashboard.yaml "$DASHBOARD_FILE"

# Check if configuration.yaml exists
CONFIG_FILE="$CONFIG_DIR/configuration.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: configuration.yaml not found in $CONFIG_DIR."
  exit 1
fi

# Check if lovelace configuration already exists
if grep -q "^lovelace:" "$CONFIG_FILE"; then
  echo "Lovelace configuration already exists in configuration.yaml"
  echo "Please add the following to your existing lovelace configuration:"
  echo ""
  echo "  dashboards:"
  echo "    mobile-dashboard:"
  echo "      mode: yaml"
  echo "      title: Mobile Dashboard"
  echo "      icon: mdi:cellphone"
  echo "      show_in_sidebar: true"
  echo "      filename: dashboard.yaml"
else
  # Add lovelace configuration
  echo "Adding lovelace configuration to configuration.yaml"
  cat >> "$CONFIG_FILE" << EOF

# Mobile Dashboard
lovelace:
  mode: yaml
  dashboards:
    mobile-dashboard:
      mode: yaml
      title: Mobile Dashboard
      icon: mdi:cellphone
      show_in_sidebar: true
      filename: dashboard.yaml
EOF
fi

echo ""
echo "Installation complete!"
echo "Please restart Home Assistant to apply changes."
echo "You may need to install the button-card custom component via HACS."
echo "Your dashboard will be available at /lovelace/mobile-dashboard"
