import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/code_template.dart';
import '../providers/code_editor_provider.dart';
import '../widgets/template_card.dart';
import 'advanced_code_editor_screen.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategoryFilter = 'All'; // Default filter

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      // Rebuild the list with filtered results
    });
  }

  List<CodeTemplate> _getFilteredTemplates(List<CodeTemplate> allTemplates) {
    List<CodeTemplate> filteredTemplates = allTemplates;

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredTemplates = filteredTemplates.where((template) {
        return template.name.toLowerCase().contains(query) ||
               template.description.toLowerCase().contains(query);
      }).toList();
    }

    // Apply category filter
    if (_selectedCategoryFilter != 'All') {
      filteredTemplates = filteredTemplates.where((template) {
        return template.category == _selectedCategoryFilter;
      }).toList();
    }

    return filteredTemplates;
  }

  @override
  Widget build(BuildContext context) {
    final allTemplates = CodeTemplate.getTemplates();
    final filteredTemplates = _getFilteredTemplates(allTemplates);
    final codeEditorProvider =
        Provider.of<CodeEditorProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a New Project'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('File')),
          TextButton(onPressed: () {}, child: const Text('Edit')),
          TextButton(onPressed: () {}, child: const Text('View')),
          TextButton(onPressed: () {}, child: const Text('Help')),
          const SizedBox(width: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Log In')),
          const SizedBox(width: 8),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white),
              child: const Text('Sign Up')),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Start a New Project',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose a template to kickstart your C++ learning or game development journey. Browse categories or let our AI set up the scaffolding for you.',
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 24),
              // Search and Filter
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search templates (e.g., 'Loops', '3D Physics')",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _selectedCategoryFilter,
                    items: <String>['All', 'Fundamentals', 'Graphics', 'Physics', 'Game Development'] // Example categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategoryFilter = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // AI Template Generator
              _buildAiTemplateCard(context),
              const SizedBox(height: 24),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 4.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: filteredTemplates.length,
                itemBuilder: (context, index) {
                  final template = filteredTemplates[index];
                  return InkWell(
                    onTap: () {
                      codeEditorProvider.loadTemplate(template.code);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AdvancedCodeEditorScreen(),
                        ),
                      );
                    },
                    child: TemplateCard(
                      name: template.name,
                      description: template.description,
                      difficulty: 'Beginner', // Placeholder
                      category: template.category, // Use actual category
                      icon: _getIconForTemplate(template.name),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAiTemplateCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        color: Colors.grey[850],
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: Icon(Icons.smart_toy, size: 64, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Chip(
                      label: Text('New Feature'),
                      backgroundColor: Colors.purple,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    const SizedBox(height: 8),
                    const Text('AI Template Generator',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'Not sure where to start? Describe the game or program you want to build and our AI will generate a custom starter project with comments explaining the code.',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Generate Project'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData _getIconForTemplate(String templateName) {
    switch (templateName) {
      case 'Hello World':
        return Icons.code;
      case 'Simple Calculator':
        return Icons.calculate;
      case 'Loop Example':
        return Icons.repeat;
      case 'Gama Engine Template':
        return Icons.videogame_asset;
      default:
        return Icons.article;
    }
  }
}
