import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // Project Explorer
          Tooltip(
            message: 'Project Explorer',
            child: IconButton(
              onPressed: () {
                // This is handled by the FileExplorer widget
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Project Explorer is visible'),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
              icon: const Icon(Icons.folder),
              color: Theme.of(context).primaryColor,
              isSelected: true, // Always selected since it's always visible
            ),
          ),
          // Search
          Tooltip(
            message: 'Search',
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Search functionality coming soon'),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              },
              icon: const Icon(Icons.search),
              color: Colors.grey,
            ),
          ),
          // Templates
          Tooltip(
            message: 'Templates',
            child: IconButton(
              onPressed: () {
                // Navigate to templates screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TemplatesScreen()),
                );
              },
              icon: const Icon(Icons.dashboard),
              color: Colors.grey,
            ),
          ),
          // Code Editor
          Tooltip(
            message: 'Code Editor',
            child: IconButton(
              onPressed: () {
                // Navigate to code editor screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AdvancedCodeEditorScreen()),
                );
              },
              icon: const Icon(Icons.code),
              color: Colors.grey,
            ),
          ),
          // Extensions/Plugins
          Tooltip(
            message: 'Extensions',
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Extensions/Plugins functionality coming soon'),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              },
              icon: const Icon(Icons.extension),
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          // Settings
          Tooltip(
            message: 'Settings',
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings functionality coming soon'),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}