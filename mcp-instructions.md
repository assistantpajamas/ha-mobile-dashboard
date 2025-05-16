# Installing with Home Assistant MCP

This guide explains how to use the Home Assistant MCP (Management and Control Panel) to implement this mobile dashboard.

## What is Home Assistant MCP?

Home Assistant MCP is a tool that allows you to manage and control your Home Assistant instance programmatically. It provides a way to create and modify dashboards, entities, and configurations without manually editing YAML files.

## Installation Steps

### 1. Install the MCP Server

```bash
npm install -g ha-mcp-server
# or
uvx ha-mcp-server
```

### 2. Connect to Your Home Assistant Instance

Start the MCP server with your Home Assistant instance details:

```bash
ha-mcp-server start --url https://your-home-assistant-url --token your-long-lived-access-token
```

### 3. Create the Dashboard Using MCP

Here's a script to create the dashboard using MCP commands:

```javascript
// mobile-dashboard.js
const fs = require('fs');
const { exec } = require('child_process');

// Load dashboard YAML
const dashboardYaml = fs.readFileSync('dashboard.yaml', 'utf8');

// Create new dashboard
exec('ha-mcp dashboard create --name "Mobile Dashboard" --icon "mdi:cellphone" --show-in-sidebar true', (err, stdout, stderr) => {
  if (err) {
    console.error(`Error creating dashboard: ${err}`);
    return;
  }
  
  console.log('Dashboard created successfully.');
  
  // Get the dashboard ID
  exec('ha-mcp dashboard list', (err, stdout, stderr) => {
    if (err) {
      console.error(`Error listing dashboards: ${err}`);
      return;
    }
    
    const dashboards = JSON.parse(stdout);
    const mobileDb = dashboards.find(db => db.title === 'Mobile Dashboard');
    
    if (!mobileDb) {
      console.error('Could not find Mobile Dashboard in the list.');
      return;
    }
    
    // Update the dashboard with our YAML
    exec(`ha-mcp dashboard update ${mobileDb.id} --yaml "${dashboardYaml.replace(/"/g, '\\"')}"`, (err, stdout, stderr) => {
      if (err) {
        console.error(`Error updating dashboard: ${err}`);
        return;
      }
      
      console.log('Dashboard updated successfully.');
    });
  });
});
```

### 4. Run the Script

```bash
node mobile-dashboard.js
```

## Manual MCP Commands

If you prefer to run commands manually, here's what you need to do:

1. Create a new dashboard:
   ```
   ha-mcp dashboard create --name "Mobile Dashboard" --icon "mdi:cellphone" --show-in-sidebar true
   ```

2. List dashboards to get the ID:
   ```
   ha-mcp dashboard list
   ```

3. Update the dashboard with your YAML:
   ```
   ha-mcp dashboard update YOUR_DASHBOARD_ID --file dashboard.yaml
   ```

## Troubleshooting

- If you encounter errors with custom cards, ensure they are installed via HACS
- Check your Home Assistant logs for any errors
- Verify your access token has sufficient permissions

## Resources

- [Home Assistant MCP Documentation](https://github.com/shannonhochkins/ha-mcp-server)
- [Home Assistant API](https://developers.home-assistant.io/docs/api/rest/)
- [HACS](https://hacs.xyz/) for installing custom cards
