import 'package:dct_lab/widgets/editor_panel.dart';
import 'package:dct_lab/widgets/file_explorer.dart';
import 'package:dct_lab/widgets/header_bar.dart';
import 'package:dct_lab/widgets/output_panel.dart';
import 'package:dct_lab/widgets/resizable_split_view.dart';
import 'package:dct_lab/widgets/side_nav_bar.dart';
import 'package:dct_lab/widgets/status_bar.dart';
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
  State<AdvancedCodeEditorScreen> createState() =>
      _AdvancedCodeEditorScreenState();
}

class _AdvancedCodeEditorScreenState extends State<AdvancedCodeEditorScreen> {
  final FocusNode _editorFocusNode = FocusNode();

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
      provider.setCode('''#include <stdio.h>

int main() {
    printf("Hello, World!\\n");
    return 0;
}''');
    }
  }

  void _saveCode() {
    // The code is already saved in the provider on change
    if (widget.project != null) {
      widget.project!.markSaved();
    }
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code saved!')),
    );
  }

  void _runCode() {
    // Get the BuildAndRunService
    final buildService =
        Provider.of<BuildAndRunService>(context, listen: false);
    final codeProvider = Provider.of<CodeEditorProvider>(context, listen: false);

    // Show a loading snackbar
    final snackBar = SnackBar(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 10),
          Text('Compiling and running code...'),
        ],
      ),
      duration: const Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Compile and run the code
    buildService
        .compileCode(
      codeProvider.code,
      '${Directory.systemTemp.path}/dct_lab_temp_executable',
    )
        .then((success) {
      if (success) {
        // If compilation was successful, run the code
        buildService
            .runCode('${Directory.systemTemp.path}/dct_lab_temp_executable')
            .then((output) {
          // Show the output in a dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Program Output'),
              content: Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Text(output.isNotEmpty
                      ? output
                      : 'Program executed successfully with no output'),
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

  void _compileCode() {
    final buildService = Provider.of<BuildAndRunService>(context, listen: false);
    final codeProvider = Provider.of<CodeEditorProvider>(context, listen: false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text('Compiling code...'),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );

    buildService.compileCode(
      codeProvider.code,
      '${Directory.systemTemp.path}/dct_lab_temp_executable',
    ).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compilation successful!')),
        );
      } else {
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

  void _openSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings button pressed! (Not implemented yet)')),
    );
  }

  @override
  void dispose() {
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderBar(
            onRun: _runCode,
            onSave: _saveCode,
            onCompile: _compileCode,
            onSettings: _openSettings,
          ),
          const Divider(height: 1, color: Colors.black),
          Expanded(
            child: Row(
              children: [
                const SideNavBar(),
                const FileExplorer(),
                Expanded(
                  child: ResizableSplitView(
                    left: EditorPanel(focusNode: _editorFocusNode),
                    right: const OutputPanel(),
                  ),
                ),
              ],
            ),
          ),
          const StatusBar(),
        ],
      ),
    );
  }
}