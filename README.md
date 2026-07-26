# Windows Subsystem for Linux (WSL) 2.7.11

> Comprehensive Technical Documentation for Windows Subsystem for Linux (WSL) 2.7.11

---

# Table of Contents

* Overview
* Features
* Architecture
* System Requirements
* Installation
* Updating WSL
* Version Verification
* Managing Linux Distributions
* Global Configuration
* Distribution Configuration
* Systemd Integration
* Networking
* Filesystem
* Storage
* Windows Integration
* Linux Integration
* WSLg (Linux GUI)
* GPU Acceleration
* USB Device Support
* Docker Integration
* Performance Optimization
* Security
* Backup and Restore
* Import & Export
* Virtual Hard Disks (VHDX)
* Troubleshooting
* Useful Commands
* Best Practices
* What's New in WSL 2.7.11
* References

---

# Overview

Windows Subsystem for Linux (WSL) enables developers, administrators, and power users to run a complete Linux environment directly on Windows without requiring a traditional virtual machine or dual-boot configuration.

WSL 2 is built on a lightweight Hyper-V virtual machine running an actual Microsoft-maintained Linux kernel, providing near-native Linux compatibility and significantly improved filesystem and networking performance compared to WSL 1.

WSL supports:

* Native Linux binaries
* Multiple Linux distributions
* Full system call compatibility
* Docker containers
* systemd
* GPU acceleration
* Linux graphical applications (WSLg)
* USB passthrough
* VS Code Remote Development
* Kubernetes development
* Cross-platform development workflows

---

# Features

* Real Linux kernel
* Lightweight virtualization
* Native filesystem performance
* Automatic memory management
* Dynamic virtual disk resizing
* Integrated networking
* Windows ↔ Linux interoperability
* GPU Compute (CUDA, DirectML, ROCm where supported)
* GUI application support
* Built-in package manager compatibility
* Full POSIX environment
* Fast startup
* Snapshot-friendly VHDX storage

---

# Architecture

```text
                     Windows 11
                          │
        ┌─────────────────┴─────────────────┐
        │        Windows Host OS            │
        └─────────────────┬─────────────────┘
                          │
                  WSL Service (LxssManager)
                          │
                  Hyper-V Utility VM
                          │
        ┌─────────────────┴─────────────────┐
        │        Linux Kernel               │
        └─────────────────┬─────────────────┘
                          │
      ┌──────────────┬──────────────┬──────────────┐
      │ Ubuntu       │ Debian       │ Arch Linux  │
      │ Fedora       │ Kali         │ openSUSE    │
      └──────────────┴──────────────┴──────────────┘
```

---

# Core Components

WSL 2.7.11 consists of several major components:

* WSL Service
* Hyper-V Utility Virtual Machine
* Microsoft Linux Kernel
* Linux init process
* systemd (optional)
* WSLg
* 9P File Server
* VirtioFS
* Virtual Hard Disk (ext4.vhdx)
* Windows Interoperability Layer

---

# System Requirements

## Supported Operating Systems

* Windows 11
* Windows 10 (latest supported builds)
* Windows Server (where supported)

## Hardware Requirements

* 64-bit CPU
* Hardware virtualization enabled
* Hyper-V support
* Second Level Address Translation (SLAT)
* Minimum 4 GB RAM (8 GB recommended)
* SSD storage recommended

---

# Verify Installed Version

```powershell
wsl --version
```

Example output:

```text
WSL version: 2.7.11
Kernel version: 6.x.x
WSLg version: x.x.x
MSRDC version: x.x.x
Direct3D version: x.x.x
DXCore version: x.x.x
Windows version: 10.0.xxxxx
```

---

# Installation

Install WSL with the default Linux distribution:

```powershell
wsl --install
```

Install WSL without a distribution:

```powershell
wsl --install --no-distribution
```

Install Ubuntu 24.04:

```powershell
wsl --install Ubuntu-24.04
```

List all available distributions:

```powershell
wsl --list --online
```

---

# Update WSL

```powershell
wsl --update
```

Verify the installation:

```powershell
wsl --version
```

---

# Shutdown WSL

```powershell
wsl --shutdown
```

---

# Launch a Distribution

```powershell
wsl
```

or

```powershell
wsl -d Ubuntu
```

---

# List Installed Distributions

```powershell
wsl --list --verbose
```

Example:

```text
NAME      STATE      VERSION
Ubuntu    Running    2
Debian    Stopped    2
```

---

# Set WSL 2 as Default

```powershell
wsl --set-default-version 2
```

---

# Convert an Existing Distribution

```powershell
wsl --set-version Ubuntu 2
```

---

# What's New in WSL 2.7.11

WSL **2.7.11** is primarily a maintenance release focused on stability and security.

### Fixes

* Fixed restoration of VHD ownership during `MoveDistribution` operations.
* Backported security fixes to the 2.7 release branch.
* General reliability and stability improvements.
* No major new features were introduced in this release.

---

# License

MIT License
