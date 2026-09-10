# Multi-SaaS Suite

A high-performance, scalable monorepo for managing multiple SaaS applications and shared packages, powered by Turborepo and TypeScript.

## 🚀 Overview

The `multi-saas-suite` is structured as a Turborepo monorepo, allowing for seamless code sharing between various SaaS applications and backend packages. It ensures ultra-fast builds, robust linting, and type checking across the entire workspace.

## 🏗️ Architecture

- **Apps** (`/apps`): Contains the individual SaaS application frontends and backends.
- **Packages** (`/packages`): Shared utility libraries, UI components, and configuration settings used across the apps.

## ⚙️ Prerequisites

- **Node.js**: Version 24 or higher
- **npm**: Version 11.13.0+

## 📦 Installation & Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Shivay00001/multi-saas-suite.git
   cd multi-saas-suite
   ```

2. Install workspace dependencies:
   ```bash
   npm install
   ```

## 💻 Usage & Scripts

The repository uses Turborepo for task orchestration. You can run these commands from the root directory to execute them across all apps and packages:

- **Start Development Mode**: 
  ```bash
  npm run dev
  ```
- **Build All Apps/Packages**: 
  ```bash
  npm run build
  ```
- **Lint Codebase**: 
  ```bash
  npm run lint
  ```
- **Format Code**: 
  ```bash
  npm run format
  ```
- **Type Checking**: 
  ```bash
  npm run check-types
  ```

## 🐳 Docker Support

You can run the suite seamlessly using Docker:

```bash
docker compose up --build
```

## 📄 License
This project is proprietary or subject to the license file provided within the repository.
