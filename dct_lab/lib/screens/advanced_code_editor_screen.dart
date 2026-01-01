import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/code_editor_provider.dart';
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
    // TODO: Implement actual code execution
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Running code...'))
    );
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