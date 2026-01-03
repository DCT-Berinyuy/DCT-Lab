import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:process_run/shell.dart';

class BuildAndRunService extends ChangeNotifier {
  bool _isBuilding = false;
  bool _isRunning = false;
  String _buildOutput = '';
  String _runOutput = '';
  String _errorOutput = '';

  bool get isBuilding => _isBuilding;
  bool get isRunning => _isRunning;
  String get buildOutput => _buildOutput;
  String get runOutput => _runOutput;
  String get errorOutput => _errorOutput;

  Future<bool> compileCode(String sourceCode, String outputPath) async {
    _isBuilding = true;
    _buildOutput = '';
    _errorOutput = '';
    notifyListeners();

    try {
      // Write the source code to a temporary file
      final tempDir = await Directory.systemTemp.createTemp('dct_lab_');
      final sourceFile = File('${tempDir.path}/temp_code.c');
      await sourceFile.writeAsString(sourceCode);

      // Check if the code includes gama.h to determine if we need special compilation
      String compileCommand;
      if (sourceCode.contains('#include <gama.h>')) {
        // For Gama Engine code, we need to link with the Gama library
        // Get the absolute path to the project root
        String scriptDir = Directory.fromUri(Platform.script).parent.path;
        String projectRoot;

        // If the script is in dct_lab/lib, go up two levels to the main project directory
        if (scriptDir.contains('/dct_lab/lib')) {
          projectRoot = scriptDir.substring(0, scriptDir.indexOf('/dct_lab/lib'));
        } else {
          // Fallback: try to determine project root from current working directory
          String currentDir = Directory.current.path;
          if (currentDir.endsWith('/dct_lab')) {
            projectRoot = currentDir.substring(0, currentDir.length - 8); // Remove '/dct_lab'
          } else {
            projectRoot = currentDir;
          }
        }

        String gamaLibPath = '$projectRoot/dct_lab/build/native';
        String gamaIncludePath = '$projectRoot/lib/gama';

        // Use the correct library name (libvgama.so)
        compileCommand = 'gcc ${sourceFile.path} -o $outputPath -I$gamaIncludePath -L$gamaLibPath -lvgama -ldl -lm -lpthread';
      } else {
        // Standard C compilation
        compileCommand = 'gcc ${sourceFile.path} -o $outputPath';
      }

      // Compile the C code using gcc
      final shell = Shell(workingDirectory: tempDir.path);
      final results = await shell.run(compileCommand);

      // Shell.run() returns a List<ProcessResult>, we need the first one
      if (results.isNotEmpty && results[0].exitCode == 0) {
        _buildOutput = 'Compilation successful!';
        _isBuilding = false;
        notifyListeners();
        return true;
      } else {
        // Handle error output
        if (results.isNotEmpty) {
          _errorOutput = results[0].stderr.toString();
          // Also include stdout in case of compilation errors
          _errorOutput += '\n' + results[0].stdout.toString();
        } else {
          _errorOutput = 'Compilation failed with no output';
        }
        _isBuilding = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorOutput = e.toString();
      _isBuilding = false;
      notifyListeners();
      return false;
    }
  }

  Future<String> runCode(String executablePath) async {
    _isRunning = true;
    _runOutput = '';
    notifyListeners();

    try {
      // Set the library path to include the Gama library
      Map<String, String> env = Map.from(Platform.environment);
      String scriptDir = Directory.fromUri(Platform.script).parent.path;
      String projectRoot;

      // If the script is in dct_lab/lib, go up two levels to the main project directory
      if (scriptDir.contains('/dct_lab/lib')) {
        projectRoot = scriptDir.substring(0, scriptDir.indexOf('/dct_lab/lib'));
      } else {
        // Fallback: try to determine project root from current working directory
        String currentDir = Directory.current.path;
        if (currentDir.endsWith('/dct_lab')) {
          projectRoot = currentDir.substring(0, currentDir.length - 8); // Remove '/dct_lab'
        } else {
          projectRoot = currentDir;
        }
      }

      String gamaLibPath = '$projectRoot/dct_lab/build/native';

      // Add the Gama library path to LD_LIBRARY_PATH
      String currentLdPath = env['LD_LIBRARY_PATH'] ?? '';
      if (currentLdPath.isNotEmpty) {
        env['LD_LIBRARY_PATH'] = '$gamaLibPath:$currentLdPath';
      } else {
        env['LD_LIBRARY_PATH'] = gamaLibPath;
      }

      // For Gama Engine applications, we need to spawn the process separately
      // so the window can be visible and interactive
      final process = await Process.start(executablePath, [], environment: env);

      // Listen for stdout
      process.stdout.transform(utf8.decoder).listen((data) {
        _runOutput += data;
        notifyListeners();
      });

      // Listen for stderr
      process.stderr.transform(utf8.decoder).listen((data) {
        _errorOutput += data;
        notifyListeners();
      });

      // Wait for the process to complete
      final exitCode = await process.exitCode;

      _isRunning = false;
      notifyListeners();

      return _runOutput;
    } catch (e) {
      _errorOutput = e.toString();
      _isRunning = false;
      notifyListeners();
      return '';
    }
  }

  Future<bool> checkCompiler() async {
    try {
      final shell = Shell();
      final results = await shell.run('gcc --version');
      return results.isNotEmpty && results[0].exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  void clearOutputs() {
    _buildOutput = '';
    _runOutput = '';
    _errorOutput = '';
    notifyListeners();
  }
}