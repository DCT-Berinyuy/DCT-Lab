import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/code_editor_provider.dart';
import '../providers/build_and_run_service.dart';
import '../models/project_model.dart';

class AdvancedCodeEditorScreen extends StatefulWidget {
  final Project? project;
  
  const AdvancedCodeEditorScreen({super.key, this.project});

  @override
  State<AdvancedCodeEditorScreen> createState() => _AdvancedCodeEditorScreenState();
}

class _AdvancedCodeEditorScreenState extends State<AdvancedCodeEditorScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _editorFocusNode = FocusNode();
  String _currentFile = 'main.c';
  
  @override
  void initState() {
    super.initState();
    // Load initial code if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialCode();
    });
  }
  
  void _loadInitialCode() {
    final provider = Provider.of<CodeEditorProvider>(context, listen: false);
    if (provider.code.isEmpty) {
      _codeController.text = '''#include <stdio.h>

int main() {
    printf("Hello, World!\\n");
    return 0;
}''';
      provider.setCode(_codeController.text);
    } else {
      _codeController.text = provider.code;
    }
  }
  
  void _saveCode() {
    final provider = Provider.of<CodeEditorProvider>(context, listen: false);
    provider.setCode(_codeController.text);
    
    if (widget.project != null) {
      widget.project!.markSaved();
    }
  }
  
  void _runCode() {
    _saveCode();

    // Get the BuildAndRunService
    final buildService = Provider.of<BuildAndRunService>(context, listen: false);

    // Show a loading snackbar
    final snackBar = SnackBar(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 10),
          Text('Compiling and running code...'),
        ],
      ),
      duration: const Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Compile and run the code
    buildService.compileCode(
      _codeController.text,
      '${Directory.systemTemp.path}/dct_lab_temp_executable',
    ).then((success) {
      if (success) {
        // If compilation was successful, run the code
        buildService.runCode('${Directory.systemTemp.path}/dct_lab_temp_executable').then((output) {
          // Show the output in a dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Program Output'),
              content: Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Text(output.isNotEmpty ? output : 'Program executed successfully with no output'),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      } else {
        // Show compilation error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Compilation Error'),
            content: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Text(buildService.errorOutput),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    });
  }
  
  @override
  void dispose() {
    _codeController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project?.name ?? 'Untitled Project'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCode,
            tooltip: 'Save',
          ),
          IconButton(
            icon: const Icon(Icons.run_circle),
            onPressed: _runCode,
            tooltip: 'Run Code',
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'new') {
                // Create new file
              } else if (result == 'open') {
                // Open file
              } else if (result == 'template') {
                // Show templates
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'new',
                child: Text('New File'),
              ),
              const PopupMenuItem<String>(
                value: 'open',
                child: Text('Open File'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'template',
                child: Text('Templates'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // File tabs
          Container(
            height: 40,
            color: Theme.of(context).dividerColor,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text('main.c'),
                ),
              ],
            ),
          ),
          // Editor area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _codeController,
                    focusNode: _editorFocusNode,
                    decoration: const InputDecoration(
                      hintText: '// Write your C code here...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontFamily: 'Monospace',
                      fontSize: 14.0,
                    ),
                    onChanged: (value) {
                      // Update provider when text changes
                      final provider = Provider.of<CodeEditorProvider>(context, listen: false);
                      provider.setCode(value);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _runCode,
        tooltip: 'Run Code',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}