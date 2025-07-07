# The Art of Site Reliability Engineering (SRE) with Azure

This repository is a companion demo for the book **The Art of Site Reliability Engineering (SRE) with Azure** by Unai. It provides practical examples, infrastructure-as-code templates, and a sample .NET web application to help you learn and apply SRE principles on Microsoft Azure.

<img src="https://user-images.githubusercontent.com/64772417/204004573-e4793fe1-1e45-46ad-8e2f-96514ffb2429.png" width="250"/>

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Infrastructure as Code (Bicep)](#infrastructure-as-code-bicep)
- [Application](#application)
- [Development Environment](#development-environment)
- [Useful Links](#useful-links)
- [License](#license)

---

## Overview

This repository demonstrates SRE best practices using Azure services. It includes:

- Modular Bicep templates for deploying Azure infrastructure.
- A sample .NET web application with telemetry and monitoring.
- Example configurations for reliability, observability, and automation.

---

## Repository Structure

```
.
├── infra/                # Bicep modules for Azure infrastructure
│   ├── main.bicep
│   └── modules/
│       ├── acr.bicep
│       ├── app-config.bicep
│       ├── app-insights.bicep
│       ├── container-app.bicep
│       ├── key-vault.bicep
│       ├── log-analytics.bicep
│       └── user-mi.bicep
├── src/                  # .NET web application source code
│   ├── ApiHelper.cs
│   ├── Program.cs
│   ├── MyTelemetryInitializer.cs
│   ├── Pages/
│   ├── wwwroot/
│   └── ...
├── links.md              # Quick access to book links
├── README.md             # This documentation
└── SRE_with_Azure_v2.sln # Solution file
```

---

## Getting Started

### Prerequisites

- [.NET SDK](https://dotnet.microsoft.com/download)
- [Node.js & npm](https://nodejs.org/)
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Docker](https://www.docker.com/)
- [Bicep CLI](https://docs.microsoft.com/azure/azure-resource-manager/bicep/install)

### Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/SRE_with_Azure_v2.git
   cd SRE_with_Azure_v2
   ```

2. **Provision Azure Infrastructure:**
   ```bash
   az login
   az deployment sub create --location <location> --template-file infra/main.bicep
   ```

3. **Build and Run the Application:**
   ```bash
   cd src
   dotnet build
   dotnet run
   ```

4. **(Optional) Run in Docker:**
   ```bash
   docker build -t sre-demoapp .
   docker run -p 8080:80 sre-demoapp
   ```

---

## Infrastructure as Code (Bicep)

- Modular Bicep templates are provided in the `infra/` directory.
- Each module (e.g., `acr.bicep`, `app-insights.bicep`) represents a specific Azure resource.
- The `main.bicep` file orchestrates the deployment.

---

## Application

- The `src/` directory contains a .NET web application.
- Features include:
  - Telemetry integration (Application Insights)
  - Example pages for monitoring, user info, and weather
  - Sample API helpers and context accessors

---

## Development Environment

This repository is designed for use in a Dev Container, with the following tools pre-installed:

- Git (latest, built from source)
- Node.js, npm, and ESLint
- .NET SDK and C# language extension
- Docker CLI

---

## Useful Links

- [Links from the Book](links.md)
- [Azure Bicep Documentation](https://docs.microsoft.com/azure/azure-resource-manager/bicep/)
- [Site Reliability Engineering (Google)](https://sre.google/)

---

# Links found in the books

You can quickly access the links found in the book [here](links.md)
