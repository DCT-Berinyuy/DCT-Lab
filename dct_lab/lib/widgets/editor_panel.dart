import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:google_fonts/google_fonts.dart'; // Re-enabled
import 'package:highlight/languages/cpp.dart';
import 'package:provider/provider.dart';

import '../providers/code_editor_provider.dart';

class EditorPanel extends StatefulWidget {
  final FocusNode focusNode;
  const EditorPanel({super.key, required this.focusNode});

  @override
  State<EditorPanel> createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel> {
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();
    final codeProvider = Provider.of<CodeEditorProvider>(context, listen: false);
    _codeController = CodeController(
      text: codeProvider.code,
      language: cpp,
    )..addListener(() {
        codeProvider.setCode(_codeController!.text);
      });
  }

  @override
  void didUpdateWidget(covariant EditorPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    final codeProvider = Provider.of<CodeEditorProvider>(context, listen: false);
    if (_codeController?.text != codeProvider.code) {
      _codeController?.text = codeProvider.code;
    }
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          color: Theme.of(context).cardColor,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTab(context, 'main.c', true), // Changed to main.c to match C files
              _buildTab(context, 'gama.h', false),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CodeTheme(
              data: CodeThemeData(
                styles: monokaiSublimeTheme,
                textStyle: GoogleFonts.firaCode().copyWith(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              child: CodeField(
                controller: _codeController!,
                focusNode: widget.focusNode,
                textStyle: GoogleFonts.firaCode(fontSize: 14),
                // Enable scrolling behavior
                maxLines: null,
                expands: false,
                // Add scroll physics to ensure proper scrolling
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String title, bool isActive) {
    return Container(
      color: isActive ? Theme.of(context).colorScheme.background : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // Add functionality to switch between tabs
          _switchToTab(title);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
            if (title != 'main.c') // Don't show close button for main file
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // Add functionality to close tab
                    _closeTab(title);
                  },
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _switchToTab(String title) {
    // Add logic to switch to the selected tab
    // For now, just show a snackbar
    final snackBar = SnackBar(
      content: Text('Switched to $title'),
      duration: const Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _closeTab(String title) {
    // Add logic to close the selected tab
    // For now, just show a snackbar
    final snackBar = SnackBar(
      content: Text('Closed $title'),
      duration: const Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}