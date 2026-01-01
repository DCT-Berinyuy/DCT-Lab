import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/code_template.dart';
import '../providers/code_editor_provider.dart';
import 'advanced_code_editor_screen.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = CodeTemplate.getTemplates();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Templates'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final template = templates[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(template.name),
              subtitle: Text(template.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Load the template into the code editor
                final provider = Provider.of<CodeEditorProvider>(context, listen: false);
                provider.loadTemplate(template.code);
                
                // Navigate to the code editor
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdvancedCodeEditorScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}