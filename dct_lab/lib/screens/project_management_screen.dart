import 'package:dct_lab/screens/advanced_code_editor_screen.dart';
import 'package:dct_lab/widgets/side_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/project_model.dart';
import '../providers/project_provider.dart';
import '../widgets/project_card.dart';

class ProjectManagementScreen extends StatefulWidget {
  const ProjectManagementScreen({super.key});

  @override
  State<ProjectManagementScreen> createState() =>
      _ProjectManagementScreenState();
}

class _ProjectManagementScreenState extends State<ProjectManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedLanguageFilter = 'All'; // Default filter

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

  List<Project> _getFilteredProjects(List<Project> allProjects) {
    List<Project> filteredProjects = allProjects;

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredProjects = filteredProjects.where((project) {
        return project.name.toLowerCase().contains(query) ||
               project.mainFile.toLowerCase().contains(query); // Simple example, extend as needed
      }).toList();
    }

    // Apply language filter
    if (_selectedLanguageFilter != 'All') {
      filteredProjects = filteredProjects.where((project) {
        final language = project.mainFile.endsWith('.cpp') ? 'C++' : 'C';
        return language == _selectedLanguageFilter;
      }).toList();
    }

    return filteredProjects;
  }

  void _showNewProjectDialog(BuildContext context) {
    final projectNameController = TextEditingController();
    final projectProvider = Provider.of<ProjectProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Project'),
          content: TextField(
            controller: projectNameController,
            decoration: const InputDecoration(hintText: 'Project Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (projectNameController.text.isNotEmpty) {
                  projectProvider.createNewProject(
                      projectNameController.text, '/path/to/new/project');
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvancedCodeEditorScreen(
                          project: projectProvider.currentProject),
                    ),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNavBar(),
          Expanded(
            child: Consumer<ProjectProvider>(
              builder: (context, projectProvider, child) {
                final filteredProjects = _getFilteredProjects(projectProvider.projects);

                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'My Projects',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Manage and organize your C/C++ game projects.',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showNewProjectDialog(context),
                            icon: const Icon(Icons.add),
                            label: const Text('New Project'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Search and Filter
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search projects by name, tag, or language...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value: _selectedLanguageFilter,
                            items: <String>['All', 'C', 'C++']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLanguageFilter = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Project Grid
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: filteredProjects.length + 1, // +1 for "Create New" card
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return _buildCreateNewCard(context);
                            }
                            final project = filteredProjects[index - 1];
                            return InkWell(
                              onTap: () {
                                projectProvider.loadProject(project);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AdvancedCodeEditorScreen(project: project),
                                  ),
                                );
                              },
                              child: ProjectCard(
                                name: project.name,
                                description:
                                    'A retro-style space arcade game with particle effects.',
                                lastModified: '2h ago',
                                language: project.mainFile.endsWith('.cpp')
                                    ? 'C++'
                                    : 'C',
                                imageUrl:
                                    'https://picsum.photos/seed/${project.name}/300/200',
                                category: '3D',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateNewCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => _showNewProjectDialog(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Create New',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start from scratch or template',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}