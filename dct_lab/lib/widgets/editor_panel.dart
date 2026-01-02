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
              _buildTab(context, 'main.cpp', true),
              _buildTab(context, 'player.h', false),
            ],
          ),
        ),
        Expanded(
          child: CodeTheme(
            data: CodeThemeData(styles: monokaiSublimeTheme),
            child: CodeField(
              controller: _codeController!,
              focusNode: widget.focusNode,
              textStyle: GoogleFonts.firaCode(), // Reverted to GoogleFonts.firaCode()
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
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}