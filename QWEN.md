# Gama Engine - Comprehensive Project Documentation

## Project Overview

Gama is a lightweight, minimalist game engine designed for simplicity and speed. It combines a powerful C library for game logic with a modern toolchain written in V, providing a fast, fun, and productive development experience. With an embedded TCC compiler, Gama is a zero-dependency tool that allows you to create, build, and run your games right out of the box without installing any external compilers.

### Key Features
- **Simple C API**: A straightforward, easy-to-learn C library for creating games
- **2D Physics Engine**: Built-in support for bodies, shapes, and collision detection
- **3D Graphics Support**: Full 3D rendering pipeline with OBJ model loading, lighting, and camera systems
- **Rendering Primitives**: Functions for drawing shapes, lines, images, and text
- **Animation Helpers**: A set of functions to easily animate values over time
- **Modern CLI Tool**: A simple and fast project manager written in V
- **Zero-Dependency**: Comes with a built-in TCC compiler for a hassle-free setup
- **Cross-Platform (in development)**: Aims to support Windows, Linux, and Web

## Architecture and Technology Stack

The Gama Engine consists of two main components:

1. **V Language CLI Tool** (`cli.v`): The command-line interface for project management, built in V
2. **C Library** (`lib/` directory): The core graphics, physics, and game API implementation

### File Structure
```
gama/
├── cli.v                    # Main V CLI tool
├── gama                     # Compiled executable
├── gama_docs.md            # Comprehensive documentation
├── README.md               # Project overview
├── LICENSE                 # MIT license
├── vgama/                  # V modules for project management
│   ├── conf.v              # Project configuration handling
│   ├── installation.v      # Installation management
│   ├── project.v           # Core project structure
│   ├── generate.v          # Project generation
│   ├── build.v, compiler.v # Build system
│   └── ...
├── lib/                    # Core C library
│   ├── gama.h              # Main header file
│   ├── animate.h           # Animation utilities
│   ├── body.h, physics.h   # Physics engine
│   ├── draw.h              # Drawing functions
│   ├── key.h               # Input handling
│   └── ...
│   └── 3d/                 # 3D graphics functionality
│       ├── camera.h        # Camera system
│       ├── image.h         # 3D image handling
│       ├── light.h         # Lighting system
│       ├── mesh.h          # 3D mesh structure
│       ├── mtl.h           # Material loading
│       ├── obj.h           # OBJ file loading
│       ├── position.h      # 3D position system
│       ├── project.h       # 3D projection system
│       ├── scene.h         # Scene management
│       └── transform.h     # 3D transformations
├── templates/              # Project templates
│   ├── skeleton/           # Basic template
│   ├── pong/, pong_advance/ # Advanced examples
├── assets/                 # Asset files
├── runners/                # Platform runners
└── bin/                    # Binary files
```

## Building and Running

### Prerequisites
- V language compiler installed

### Building the CLI Tool
```bash
# Clone the repository
git clone https://github.com/username/gama.git
cd gama

# Build the CLI tool
v -prod cli.v -o gama
```

### Using the CLI Tool
The `gama` executable serves as the main project management tool with several commands:

| Command | Description |
|---------|-------------|
| `gama create` | Starts an interactive assistant to create a new project |
| `gama build` | Compiles your project into an executable in the `build/` dir |
| `gama run` | Runs a previously built project |
| `gama dev` | Builds and runs the project, with auto-rebuild on changes |
| `gama lib reset` | Reset the project's gama library to the CLI tool's version |
| `gama package` | Package the current gama project into a setup |

### Creating Your First Project
1. Run `gama create` to start the interactive project creation assistant
2. Choose a project name (lowercase letters, numbers, underscores only)
3. Select a template (skeleton, pong, pong_advance)
4. Choose a compiler (builtin TCC or system compiler)
5. Navigate to your project directory: `cd your_project_name`
6. Run the development server: `gama dev` (auto-reloads on changes)

### Basic Project Structure
```
project_name/
├── gama.toml          # Project configuration file
├── include/           # Gama library headers
├── src/               # Source code (mainly C files)
│   └── main.c         # Entry point
├── assets/            # Game assets
└── build/             # Compiled executables
```

## Development Conventions

### Code Structure
- Projects are built in C using the Gama C API
- The main function should follow the pattern: init → game loop → cleanup
- Use `gm_yield()` for the main game loop condition
- Always use `gm_dt()` for time-based calculations to maintain consistency across frame rates

### Configuration
- Project metadata is stored in `gama.toml`
- The engine version and compiler settings are specified in the `[gama]` section
- Supported compilers include clang, gcc, tcc, and msvc

### Project Templates
- **skeleton**: Minimal template with basic structure
- **pong**: Simple Pong game example demonstrating basic gameplay
- **pong_advance**: Advanced Pong game with more features

### API Overview
The C API provides several key categories of functionality:

1. **Initialization and Window Management**:
   - `gm_init(width, height, title)` - Initialize the engine
   - `gm_yield()` - Process events and continue game loop
   - `gm_quit()` - Close the engine

2. **Graphics and Drawing**:
   - Shape drawing functions (lines, rectangles, circles, etc.)
   - Image and text rendering
   - Color utilities

3. **Physics System**:
   - Body creation and management
   - Collision detection and response
   - Systems for organizing bodies

4. **3D Graphics System**:
   - 3D position and transformation system (`gm3Pos`, `gm3Transform`)
   - Mesh loading and management (`gm3Mesh`)
   - OBJ and MTL file loading (`gm3_obj_load()`)
   - Scene management with lighting and camera (`gm3Scene`, `gm3Light`, `gm3Camera`)
   - 3D projection and rendering (`gm3_project()`, `gm3_draw_image()`)
   - Lighting with Blinn-Phong shading model

5. **Animation**:
   - Various easing functions (spring, linear, ease-in/out)
   - Wave animations (sin, cos)

6. **Input Handling**:
   - Keyboard and mouse input
   - Key shortcuts using character notation

### Development Workflow
1. Develop iteratively using `gama dev` for live reloading
2. Test builds with `gama build`
3. Package finished projects with `gama package`
4. Use `gama lib reset` to update project's copy of the Gama library

## Project Origin
This project provides a comprehensive game engine framework written in C with a V language CLI tool. The combination of a simple C API with a modern build system makes it accessible to developers seeking a lightweight solution for 2D games and visualizations. The project emphasizes simplicity, ease of use, and zero-dependency deployment.

## Special Features
- Real-time development with auto-reload capability
- Embedded TCC compiler for zero-dependency setup
- Comprehensive physics engine with collision detection
- Built-in animation utilities
- Data visualization capabilities
- Full 3D rendering pipeline with OBJ model support

## Lineup Project - Real-World Example
The Gama Engine includes a comprehensive real-world example called "lineup" in the Projects/lineup directory. This is a graphical, animated linear regression tool that demonstrates Gama's capabilities beyond traditional game development.

### Key Features of the Lineup Project:
- **Interactive Data Points**: Users can click and drag to add and move data points
- **Real-time Linear Regression**: The line automatically adjusts to fit the user's data points using gradient descent
- **Learning Algorithm Visualization**: Shows how gradient descent works visually
- **Grid System**: Includes coordinate grid with labeled axes for precise positioning
- **Animated Elements**: Uses Gama's animation system for smooth visual feedback

### Implementation Details:
- Located in `Projects/lineup/` directory
- Uses custom headers for different components:
  - `gridlines.h`: Draws coordinate grid system
  - `line.h`: Implements linear regression algorithm and plotting
  - `user_points.h`: Manages user-placed data points
  - `utils.h`: Contains utility functions for display

### Linear Regression Algorithm:
The project implements gradient descent for linear regression with:
- Dynamic calculation of gradient and intercept: `y = gradient * x + intercept`
- Real-time loss calculation (mean absolute error)
- Visual feedback showing current loss value
- Animated line that adjusts to best fit the user data points

### User Interface Elements:
- Fullscreen mode with black background for good contrast
- Interactive grid with labeled axes
- Color-coded data points (orange for selected, purple for others)
- Real-time display of the regression equation and loss value
- Animate points with sine wave for visual appeal

This project demonstrates how Gama can be used for educational tools, scientific visualization, and interactive applications beyond traditional gaming, showcasing the engine's versatility.

## 3D Graphics System

The Gama Engine now includes a comprehensive 3D graphics system with the following capabilities:

### Core 3D Components
- **3D Position System** (`position.h`): 3D vector operations with x, y, z coordinates
- **3D Transformations** (`transform.h`): Position, rotation, and scale transformations
- **Mesh System** (`mesh.h`): 3D mesh structure with vertices, faces, normals, and texture coordinates
- **Camera System** (`camera.h`): Camera with focal length and near/far clipping planes
- **Lighting System** (`light.h`): Point lights with color, intensity, and ambient lighting
- **Scene Management** (`scene.h`): Scene structure combining camera and lighting
- **OBJ Loading** (`obj.h`): Full support for loading OBJ model files with materials
- **MTL Loading** (`mtl.h`): Material library support for OBJ models
- **3D Projection** (`project.h`): Perspective projection and rendering pipeline
- **3D Image System** (`image.h`): Handling of projected 3D models for 2D rendering

### 3D Rendering Pipeline
1. **Model Loading**: Load OBJ models with `gm3_obj_load()`
2. **Transformation**: Apply transformations with `gm3Transform`
3. **Projection**: Project 3D models to 2D screen space with `gm3_project()`
4. **Rendering**: Draw projected models with `gm3_draw_image()`

### Example 3D Usage
```c
#include <gama.h>
#include <3d.h>

int main() {
    gm_init(800, 600, "3D Example");

    // Load a 3D model
    gm3Mesh mesh;
    gm3_obj_load(&mesh, "assets/model.obj", "assets/");

    // Set up scene
    gm3Scene scene = gm3_scene();
    scene.camera.focal = 1.0;
    scene.light.position = gm3pos(0, 5, 5);

    // Set up transform
    gm3Transform transform = gm3_transform();
    transform.rotation.y = 0.5;

    while(gm_yield()) {
        gm_background(GM_BLACK);

        // Project and draw the 3D model
        gm3Image image = gm3_image();
        gm3_project(&mesh, &transform, &scene, &image);
        gm3_draw_image(&image, 0, 0);
        gm3_image_clear(&image);

        // Rotate the model
        transform.rotation.y += 0.01;
    }

    gm3_mesh_free(&mesh);
    return 0;
}
```

This 3D system enables developers to create sophisticated 3D applications while maintaining Gama's focus on simplicity and ease of use.