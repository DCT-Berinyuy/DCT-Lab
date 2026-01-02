import 'package:flutter/material.dart';

class FileExplorer extends StatelessWidget {
  const FileExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'EXPLORER',
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.folder_open, color: Colors.yellow[700]),
                  title: const Text('Project Alpha', style: TextStyle(color: Colors.white)),
                  dense: true,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.description, color: Colors.blue),
                        title: Text('main.cpp', style: TextStyle(color: Colors.white)),
                        dense: true,
                      ),
                      ListTile(
                        leading: Icon(Icons.description, color: Colors.yellow),
                        title: Text('player.h', style: TextStyle(color: Colors.white)),
                        dense: true,
                      ),
                      ListTile(
                        leading: Icon(Icons.description, color: Colors.blue),
                        title: Text('game_loop.cpp', style: TextStyle(color: Colors.white)),
                        dense: true,
                      ),
                       ListTile(
                        leading: Icon(Icons.folder, color: Colors.green),
                        title: Text('assets', style: TextStyle(color: Colors.white)),
                        dense: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}