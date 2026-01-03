import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:ffi/ffi.dart';
import '../gama_bindings.dart';

class GamaService extends ChangeNotifier {
  late GamaBindings _bindings;
  int _bodyCount = 0;
  Uint8List _framebuffer = Uint8List(0);

  GamaService() {
    _loadLibrary();
  }

  void _loadLibrary() {
    final libraryPath = Platform.isLinux
        ? 'build/native/libvgama.so'
        : Platform.isWindows
            ? 'build/native/vgama.dll'
            : throw Exception('Unsupported platform');

    final dylib = ffi.DynamicLibrary.open(libraryPath);
    _bindings = GamaBindings(dylib);
  }

  GamaBindings get bindings => _bindings;
  int get bodyCount => _bodyCount;
  Uint8List get framebuffer => _framebuffer;

  void initGame() {
    final title = 'Gama Engine from Flutter'.toNativeUtf8();
    _bindings.gm_init(800, 600, title.cast());
    calloc.free(title);
    // gm_background is called internally by gm_init, with GM_BLACK
  }

  void gameLoop() {
    final dtPtr = calloc<ffi.Double>();
    try {
      if (_bindings.gapi_yield(dtPtr) == 1) { // Use public gapi_yield
        _bodyCount = _bindings.gapi_get_body_count(); // Use public gapi_get_body_count
        
        final framebufferPtr = _bindings.gapi_get_framebuffer();
        if (framebufferPtr != ffi.nullptr) {
          _framebuffer = framebufferPtr.asTypedList(800 * 600 * 4);
        }
        
        notifyListeners();
      }
    } finally {
      calloc.free(dtPtr);
    }
  }

  void quitGame() {
    _bindings.gapi_quit(); // Use public gapi_quit
  }
}
