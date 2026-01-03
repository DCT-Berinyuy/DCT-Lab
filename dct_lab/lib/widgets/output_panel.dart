import 'package:dct_lab/widgets/game_viewport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gama_service.dart';

class OutputPanel extends StatelessWidget {
  const OutputPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Game Viewport'),
              Tab(text: 'Console'),
              Tab(text: 'Inspector'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Game Viewport
                const GameViewport(),
                // Console
                Container(
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
                ),
                // Inspector
                Consumer<GamaService>(
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
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
