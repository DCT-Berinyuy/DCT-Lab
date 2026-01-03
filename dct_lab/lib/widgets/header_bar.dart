import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRun;
  final VoidCallback onSave;
  final VoidCallback onCompile;
  final VoidCallback onSettings;

  const HeaderBar({
    super.key,
    required this.onRun,
    required this.onSave,
    required this.onCompile,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final projectProvider = Provider.of<ProjectProvider>(context, listen: true);

    return Container(
      height: 56,
      color: theme.colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Logo and Title
          Row(
            children: [
              Icon(Icons.terminal, color: theme.primaryColor, size: 28),
              const SizedBox(width: 8),
              const Text(
                'DCT Lab',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                projectProvider.currentProject?.name ?? 'No Project',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 8),
              // Project type indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: projectProvider.currentProjectType == ProjectType.gama
                      ? Colors.green.withOpacity(0.2)
                      : Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  projectProvider.currentProjectType == ProjectType.gama ? 'Gama' : 'C/C++',
                  style: TextStyle(
                    fontSize: 12,
                    color: projectProvider.currentProjectType == ProjectType.gama
                        ? Colors.green
                        : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Right side: Action Buttons
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onRun,
                icon: const Icon(Icons.play_arrow, size: 20),
                label: const Text('Run'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onCompile,
                icon: const Icon(Icons.build, size: 20),
                label: const Text('Compile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.cardColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              // Gama-specific button
              if (projectProvider.currentProjectType == ProjectType.gama)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add Gama-specific functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Gama-specific tools activated'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.gamepad, size: 20),
                    label: const Text('Gama Tools'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              const VerticalDivider(width: 24, indent: 12, endIndent: 12),
              IconButton(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                tooltip: 'Save',
                color: Colors.white,
              ),
              IconButton(
                onPressed: onSettings,
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}