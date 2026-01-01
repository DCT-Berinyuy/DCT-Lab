import 'dart:io';

class CompilerUtils {
  // Method to compile C code
  static Future<ProcessResult?> compileCCode(String sourceCode, String outputPath) async {
    // Write the source code to a temporary file
    final tempFile = await _writeTempFile(sourceCode, '.c');
    
    // Compile the C code using gcc
    final result = await Process.run(
      'gcc', 
      [tempFile.path, '-o', outputPath],
      runInShell: true
    );
    
    // Clean up the temporary file
    await tempFile.delete();
    
    return result;
  }
  
  // Method to run compiled code
  static Future<ProcessResult?> runCompiledCode(String executablePath) async {
    final result = await Process.run(executablePath, [], runInShell: true);
    return result;
  }
  
  // Helper method to write source code to a temporary file
  static Future<File> _writeTempFile(String content, String extension) async {
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/temp_code${extension}');
    await file.writeAsString(content);
    return file;
  }
  
  // Method to check if compiler is available
  static Future<bool> isCompilerAvailable(String compiler) async {
    try {
      final result = await Process.run(compiler, ['--version'], runInShell: true);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }
}