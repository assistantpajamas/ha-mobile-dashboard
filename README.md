# Home Assistant Mobile Dashboard

A mobile-optimized dashboard for Home Assistant that mimics the style shown in the screenshot. This dashboard provides a clean, card-based interface with personalized views and room controls.

## Features

- Personalized dashboard sections for different users
- Room control section with icons for different rooms
- Home control section for security, media casting, and automation
- Additional views for specific rooms and functions
- Optimized for mobile devices

## Installation

### Prerequisites

1. Home Assistant with YAML mode enabled
2. HACS (Home Assistant Community Store) installed
3. The following custom cards installed via HACS:
   - button-card

### Setup Instructions

1. Copy the `dashboard.yaml` file to your Home Assistant configuration directory
2. Add the following to your `configuration.yaml`:

```yaml
lovelace:
  mode: yaml
  dashboards:
    mobile-dashboard:
      mode: yaml
      title: Mobile Dashboard
      icon: mdi:cellphone
      show_in_sidebar: true
      filename: dashboard.yaml
```

3. Restart Home Assistant
4. Access your new dashboard from the sidebar or directly at `/mobile-dashboard`

## Customization

You can customize the dashboard by editing the `dashboard.yaml` file:

- Change the entities to match your own Home Assistant setup
- Modify the colors and icons to suit your preferences
- Add or remove cards as needed

## Screenshots

The dashboard includes:
- A main view with personalized sections and room controls
- Individual views for each room
- Media controls for TVs and audio systems
- Security controls for locks and monitoring

## Notes

- This dashboard is designed for mobile devices but will work on desktop as well
- The button-card custom component is required for the styled buttons
- Ensure your entities match those in the YAML file or replace them with your own
