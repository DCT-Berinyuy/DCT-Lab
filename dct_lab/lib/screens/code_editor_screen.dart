import 'package:flutter/material.dart';

class CodeEditorScreen extends StatefulWidget {
  const CodeEditorScreen({super.key});

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Editor'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.run_circle),
            onPressed: () {
              // Run the C/C++ code
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save the file
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _codeController,
          decoration: const InputDecoration(
            hintText: '// Write your C/C++ code here...',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}