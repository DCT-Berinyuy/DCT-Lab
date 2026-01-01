# DCT Lab - Offline-First AI-Powered C/C++ Learning IDE

## Project Overview

DCT Lab is an offline-first, AI-assisted code editor designed exclusively for **C/C++ programming**, integrating a lightweight **2D/3D game engine (Gama Engine)** to help students learn programming fundamentals through hands-on, visual, and game-based experimentation.

## Core Features

- **Offline-first C/C++ code editor**
- **Real-time compilation and execution** of C code
- **Built-in Gama Engine for 2D/3D game development**
- **Code templates** including Gama integration examples
- **Visual feedback** from C code execution
- **Beginner-friendly API and documentation**
- **Project management** with save/load functionality
- **Designed for students and education**

## Current Implementation

- ✅ Flutter-based cross-platform desktop application
- ✅ Syntax-highlighted code editor
- ✅ Project management system
- ✅ C code compilation and execution service
- ✅ Error handling and output display
- ✅ Code templates including Gama Engine examples
- ✅ Navigation system with templates and project management
- ✅ Provider-based state management

## Architecture

```
DCT Lab (Flutter App)
├── UI Layer (Flutter Widgets)
│   ├── Main Screen
│   ├── Advanced Code Editor
│   ├── Templates Screen
│   └── Navigation
├── State Management (Provider)
│   ├── CodeEditorProvider
│   ├── ProjectProvider
│   └── BuildAndRunService
├── Data Models
│   ├── Project
│   └── CodeTemplate
├── Utilities
│   └── CompilerUtils
└── Assets
    └── C code templates
```

## Getting Started

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- C/C++ compiler (GCC/Clang)
- CMake (for building native plugins)

### Installation
```bash
# Clone the repository
git clone <repository-url>
cd dct_lab

# Get Flutter dependencies
flutter pub get

# Run the application
flutter run -d linux  # For Linux
flutter run -d windows  # For Windows
flutter run -d macos  # For macOS
```

## Development

### Project Structure
- `lib/` - Flutter Dart code for the UI
- `lib/screens/` - UI screens (main, code editor, templates)
- `lib/providers/` - State management (CodeEditorProvider, BuildAndRunService)
- `lib/models/` - Data models (Project, CodeTemplate)
- `lib/utils/` - Utility functions
- `assets/` - Learning resources and templates
- `native/` - Native C/C++ code for Gama integration (future)
- `ios/`, `android/`, `windows/`, `linux/`, `macos/` - Platform-specific Flutter code

### Current Functionality
- Code editor with syntax highlighting
- Project creation and management
- Code compilation and execution
- Template system for learning examples
- Error handling and output display

## Development Roadmap

### UI/UX Enhancement (Next Priority)
- [ ] Redesign UI using modern design principles
- [ ] Implement dark/light mode
- [ ] Improve code editor with line numbers
- [ ] Add split view for code and output
- [ ] Create more intuitive navigation

### Gama Engine Integration
- [ ] Create native plugin for Gama Engine
- [ ] Implement 2D/3D rendering in-app
- [ ] Add game templates and examples
- [ ] Create visual debugging tools

### Advanced Features
- [ ] Syntax highlighting for C/C++
- [ ] Code completion and auto-suggestions
- [ ] Integrated debugger
- [ ] AI-powered help (when online)
- [ ] File system browser
- [ ] Multi-file project support
- [ ] Version control integration

### Educational Features
- [ ] Interactive tutorials
- [ ] Step-by-step debugging visualization
- [ ] Algorithm visualization tools
- [ ] Assessment and progress tracking

## Vision

DCT Lab aims to become the default learning environment for C programming, bridging the gap between theory and practice by allowing students to learn C by building games, not just writing console programs. The platform will provide an intuitive, visual approach to learning programming concepts through hands-on experimentation.

## Contributing

We welcome contributions! Please read our contributing guidelines for details on our code of conduct and development process.

## License

This project is licensed under the MIT License - see the LICENSE file for details.