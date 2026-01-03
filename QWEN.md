Qwen, I need your expertise to take over the development of the "DCT Lab" project. This project is a Flutter-based C/C++ IDE that aims to integrate deeply with the "Gama Engine," a C-based game engine.

Here's a comprehensive overview of the project context and current status:

**1. Overall Goal:**
The primary goal is to implement UI/UX enhancements for the DCT Lab IDE and achieve deeper, functional integration with the Gama Engine.

**2. Key Knowledge:**

*   **DCT Lab Structure:** The IDE is built with Flutter, uses `provider` for state management, and `code_text_field` for the code editor. It follows a dark theme, and `TemplatesScreen` currently serves as the home screen. A custom `ResizableSplitView` handles UI splitting.
*   **Gama Engine Structure:** The Gama Engine is written in C (source in `lib/gama`) and has a V language CLI/library (`runners/native`).
*   **Gama Build Process:** The `libvgama.so` shared library is built using the V compiler (`v -enable-globals -shared runners/native -o dct_lab/build/native/libvgama.so`). We've recently resolved a linker error (`cannot enable executable stack`) by adding `-ldflags "-z,noexecstack"` and forcing GCC compilation (`-cc gcc`).
*   **FFI Bindings:** Dart FFI bindings (`gama_bindings.dart`) are generated from `lib/gama/gapi.h` using `ffigen`.
*   **Gama Integration Strategy:** We are focusing on exposing simple game state/events via FFI. Initial attempts at complex framebuffer access using the `gg` library in V were unsuccessful, leading to the current blocker.
*   **Font Loading Issue:** The `google_fonts` network connectivity problem was resolved by manually downloading the `Fira Code` font, bundling it as an asset in `dct_lab/assets/fonts`, declaring it in `pubspec.yaml`, and setting `GoogleFonts.config.allowRuntimeFetching = false;` in `main.dart`.

**3. Recent Actions & Progress:**

*   **FFI Integration (Body Count):**
    *   The `libvgama.so` shared library now loads correctly within the Flutter app.
    *   The C code provided (`dct_lab/src/main.c`) is compilable and runnable as a standalone native app, correctly interacting with `libvgama.so`.
    *   `gapi_get_body_count()` (hardcoded to return 5) is successfully called via FFI, and its value is retrieved and displayed in the `OutputPanel`'s "Inspector" tab in the Flutter app.
    *   `GamaService` has been updated to retrieve and notify listeners of this `bodyCount`.
*   **Flutter UI Enhancements:**
    *   The `HeaderBar` in `AdvancedCodeEditorScreen` now has interactive "Compile" and "Settings" buttons.
    *   `ProjectManagementScreen` and `TemplatesScreen` have implemented search and filter functionalities.
*   **Font Issue Resolution:** The `google_fonts` problem is resolved by local bundling.

**4. Current Blockers and Next Steps for You (Qwen):**

The current major blocker is the **deeper Gama Engine integration**, specifically providing a live video feed from the Gama engine's framebuffer to a Flutter widget.

*   **Problem:** We attempted to modify `runners/native/vgama.v` to render to a `gg.Image` and expose its pixel data via `gapi_get_framebuffer`. However, the V compilation failed, indicating that the `gg` library methods like `gg.Context.begin_to_image`, `gg.new_streaming_image`, and directly accessing `gg.Image.data` are either incorrect or do not exist as assumed. My attempts to use `sokol.gl.read_pixels` also failed as I couldn't correctly get the `sokol` context from `gg.Context`.
*   **Your Task:**
    *   **Analyze `runners/native/vgama.v` and the Vlang `gg` (and potentially `sokol`) library documentation/examples to find the correct way to get raw pixel data from the rendering context after a frame is drawn.**
    *   **Implement the necessary changes in `runners/native/vgama.v` to correctly capture the framebuffer data (e.g., as a `[]u8` slice) and make it accessible via the `gapi_get_framebuffer` FFI function.**
    *   **Ensure `lib/gama/gapi.h` is correctly updated with the signature for `gapi_get_framebuffer` (currently `extern uint8_t* gapi_get_framebuffer();`).**
    *   **Regenerate FFI bindings (`gama_bindings.dart`) after modifying `gapi.h` and `vgama.v`.**
    *   **Verify that the `GameViewport` Flutter widget can successfully display the live framebuffer stream from the Gama engine.** (The `GameViewport` widget and `GamaService` are already set up to consume this data, assuming `gapi_get_framebuffer` works correctly).

Let me know if you need any more information or clarification. I believe with your understanding of Vlang and graphics, you can unblock this crucial integration step.
