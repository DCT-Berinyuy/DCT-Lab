import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:process_run/process_run.dart';

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

      // Compile the C code using gcc
      final result = await run('gcc', [sourceFile.path, '-o', outputPath]);

      if (result.exitCode == 0) {
        _buildOutput = 'Compilation successful!';
        _isBuilding = false;
        notifyListeners();
        return true;
      } else {
        _errorOutput = result.stderr.toString();
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
      final result = await Process.run(executablePath, []);
      _runOutput = result.stdout;
      _errorOutput = result.stderr;
      _isRunning = false;
      notifyListeners();
      return result.stdout;
    } catch (e) {
      _errorOutput = e.toString();
      _isRunning = false;
      notifyListeners();
      return '';
    }
  }

  Future<bool> checkCompiler() async {
    try {
      final result = await run('gcc', ['--version']);
      return result.exitCode == 0;
    } catch (e) {
      return Future.value(false);
    }
  }

  void clearOutputs() {
    _buildOutput = '';
    _runOutput = '';
    _errorOutput = '';
    notifyListeners();
  }
}