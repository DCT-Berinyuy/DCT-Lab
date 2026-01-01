# DCT Lab Development Process

## Project Vision

DCT Lab is an offline-first, AI-assisted code editor designed exclusively for **C/C++ programming**, integrating a lightweight **2D/3D game engine (Gama Engine)** to help students learn programming fundamentals through hands-on, visual, and game-based experimentation.

## Development Approach

### Architecture
- **Flutter Frontend**: Rich IDE interface with editor, console, and game preview
- **Native Backend**: C/C++ plugin that interfaces with Gama Engine
- **Process Management**: Handle compilation and execution of C programs locally
- **Resource Bundling**: Package Gama, compiler, and templates with the app

### Key Features to Implement

1. **Code Editor**
   - Syntax highlighting for C/C++
   - Line numbers
   - Auto-completion
   - Error highlighting

2. **Compiler Integration**
   - Embedded GCC/Clang compiler
   - Build and run functionality
   - Error reporting

3. **Gama Engine Integration**
   - 2D/3D rendering capabilities
   - Game templates (Snake, Pong, etc.)
   - Visual debugging tools

4. **Learning Resources**
   - Interactive tutorials
   - Code examples
   - Documentation

## Implementation Plan

### Phase 1: Basic IDE
- [x] Flutter app structure
- [x] Basic code editor screen
- [ ] Syntax highlighting
- [ ] File management (create, open, save)

### Phase 2: Compiler Integration
- [ ] Native plugin for compiler access
- [ ] Build and run functionality
- [ ] Error reporting and diagnostics

### Phase 3: Gama Engine Integration
- [ ] Native plugin for Gama Engine
- [ ] 2D/3D rendering in app
- [ ] Game templates

### Phase 4: Learning Features
- [ ] Interactive tutorials
- [ ] Visual debugging
- [ ] AI-powered help (when online)

## Technical Considerations

### Flutter Dependencies
- `flutter_code_editor` - For code editing with syntax highlighting
- `process_run` - For managing compiler processes
- `file_picker` - For file operations
- `provider` - For state management
- `flutter_markdown` - For documentation rendering

### Native Integration
- Use Flutter's platform channels to communicate with native C/C++ code
- Package Gama Engine and compiler tools with the app
- Handle cross-platform differences for file paths and execution

## Directory Structure
```
dct_lab/
├── lib/
│   ├── main.dart          # App entry point
│   ├── screens/           # UI screens
│   ├── widgets/           # Custom UI components
│   ├── models/            # Data models
│   ├── providers/         # State management
│   └── utils/             # Utility functions
├── assets/                # Static assets and templates
├── native/                # Native C/C++ code for Gama integration
├── android/               # Android-specific code
├── ios/                   # iOS-specific code
├── linux/                 # Linux-specific code
├── macos/                 # macOS-specific code
├── windows/               # Windows-specific code
└── pubspec.yaml           # Project dependencies and metadata
```

## Building and Running

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

# Run the application
flutter run -d linux  # For Linux
flutter run -d windows  # For Windows
flutter run -d macos  # For macOS
```

## Contributing

We welcome contributions! Please read our contributing guidelines for details on our code of conduct and development process.