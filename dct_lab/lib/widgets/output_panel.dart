import 'package:dct_lab/widgets/game_viewport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gama_service.dart';
import '../providers/project_provider.dart';

class OutputPanel extends StatelessWidget {
  const OutputPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context, listen: true);

    List<Widget> tabs = [];
    List<Widget> children = [];

    if (projectProvider.currentProjectType == ProjectType.gama) {
      tabs.add(const Tab(text: 'Game Viewport'));
      children.add(const GameViewport());
    }

    tabs.add(const Tab(text: 'Console'));
    children.add(Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        '[System] Gama Engine initialized v0.9.1\n'
        '[Info] Loading assets from /res/textures...\n'
        '[Info] Mesh \'Player_Model\' loaded (450ms)\n'
        '[Warning] Shader \'Standard_Lit\' is deprecated.\n'
        '[Error] main.cpp:18:13: error: expected \';\' before \'}\' token',
        style: TextStyle(
          fontFamily: 'monospace',
          color: Colors.white,
        ),
      ),
    ));

    if (projectProvider.currentProjectType == ProjectType.gama) {
      tabs.add(const Tab(text: 'Inspector'));
      children.add(Consumer<GamaService>(
        builder: (context, gamaService, child) {
          return Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gama Engine Inspector',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Body Count: ${gamaService.bodyCount}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Framebuffer Status: Active',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ));
    }

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
