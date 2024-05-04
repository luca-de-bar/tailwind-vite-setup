# Vite and Tailwind Automation Setup

This project automates the setup of a Vite application integrated with Tailwind CSS. It is designed to streamline the process of configuring a robust development environment with Vite and Tailwind, including a PostCSS plugin setup for Tailwind.

## Features

- **Vite Setup**: Automatically creates a new Vite project using the latest Vite template configured for vanilla JavaScript.
- **Tailwind CSS Integration**: Tailwind CSS is set up as a PostCSS plugin, allowing for powerful utility-first CSS directly in your HTML and JS files.
- **Configuration Files**: Automatically generates and configures `tailwind.config.js` and `postcss.config.cjs` to ensure Tailwind functions correctly with PostCSS.
- **Prettier Configuration**: Installs and configures Prettier with a Tailwind plugin to automatically sort Tailwind classes, enhancing code readability and maintenance.
- **Enhanced UI**: Implements a welcoming interface with an appealing hover effect on the Tailwind logo, demonstrating the use of Tailwind utility classes for quick UI development.

## Getting Started

### Prerequisites

Before running the setup script, ensure you have Node.js and npm installed on your machine. You can download them from [Node.js official website](https://nodejs.org/).

### Installation

1. Clone this repository or download the setup script directly.
2. Open your command line interface (CLI) and navigate to the directory where you want to set up the project.
3. Run the PowerShell script `setup.ps1` by entering the following command:

   ```sh
   .\setup.ps1
