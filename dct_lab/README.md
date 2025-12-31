# DCT Lab - Offline-First AI-Powered C/C++ Learning IDE

## Project Overview

DCT Lab is an offline-first, AI-assisted code editor designed exclusively for **C/C++ programming**, integrating a lightweight **2D game engine (Gama Engine)** to help students learn programming fundamentals through hands-on, visual, and game-based experimentation.

## Core Features

- **Offline-first C/C++ code editor**
- **Embedded GCC/Clang compiler**
- **Built-in Gama Engine for 2D/3D game development**
- **One-click game templates** (Snake, Pong, Platformer)
- **Visual feedback** from C code execution
- **Beginner-friendly API and documentation**
- **Optional AI explanations** and debugging help (online)
- **Designed for students and education**

## Architecture

```
DCT Lab (Flutter App)
├── UI Layer (Flutter Widgets)
├── Native Plugin Layer (C/C++)
│   ├── Gama Engine Integration
│   ├── Compiler Integration
│   └── File System Operations
└── Embedded Resources
    ├── Gama Library
    ├── Compiler Tools
    └── Learning Templates
```

## Getting Started

### Prerequisites
- Flutter SDK
- C/C++ compiler (GCC/Clang)
- CMake (for building native plugins)

### Installation
```bash
# Clone the repository
git clone <repository-url>
cd dct_lab

# Get Flutter dependencies
flutter pub get

# Build native plugins
# (Platform-specific build instructions will go here)

# Run the application
flutter run -d linux  # For Linux
flutter run -d windows  # For Windows
flutter run -d macos  # For macOS
```

## Development

### Project Structure
- `lib/` - Flutter Dart code for the UI
- `assets/` - Learning resources and templates
- `native/` - Native C/C++ code for Gama integration
- `ios/`, `android/`, `windows/`, `linux/`, `macos/` - Platform-specific Flutter code

### Native Plugin Integration
The app uses Flutter's native plugin architecture to interface with:
- Gama Engine for game rendering
- Local compiler tools for C/C++ compilation
- File system operations

## Vision

DCT Lab aims to become the default learning environment for C programming, bridging the gap between theory and practice by allowing students to learn C by building games, not just writing console programs.

## Contributing

We welcome contributions! Please read our contributing guidelines for details on our code of conduct and development process.

## License

This project is licensed under the MIT License - see the LICENSE file for details.