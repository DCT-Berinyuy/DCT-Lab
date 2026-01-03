import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/code_editor_provider.dart';

class FileExplorer extends StatefulWidget {
  const FileExplorer({super.key});

  @override
  State<FileExplorer> createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  // Sample file structure - in a real implementation, this would come from a project model
  final List<_FileNode> _files = [
    _FileNode(
      name: 'Project Alpha',
      type: _FileType.folder,
      children: [
        _FileNode(name: 'main.c', type: _FileType.file),
        _FileNode(name: 'gama.h', type: _FileType.file),
        _FileNode(name: 'player.h', type: _FileType.file),
        _FileNode(
          name: 'src',
          type: _FileType.folder,
          children: [
            _FileNode(name: 'game_loop.c', type: _FileType.file),
            _FileNode(name: 'physics.c', type: _FileType.file),
          ],
        ),
        _FileNode(
          name: 'assets',
          type: _FileType.folder,
          children: [
            _FileNode(name: 'textures', type: _FileType.folder),
            _FileNode(name: 'sounds', type: _FileType.folder),
          ],
        ),
      ],
    ),
  ];

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
            child: Row(
              children: [
                Text(
                  'EXPLORER',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 16),
                  onPressed: () {
                    // Refresh the file list
                    _refreshFiles();
                  },
                  tooltip: 'Refresh',
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  onPressed: () {
                    // Add new file/folder
                    _addFile();
                  },
                  tooltip: 'Add new file',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: _files.length,
              itemBuilder: (context, index) {
                return _buildFileNode(_files[index], 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileNode(_FileNode node, int depth) {
    if (node.type == _FileType.folder) {
      return _FolderTile(node: node, depth: depth);
    } else {
      return _FileTile(node: node, depth: depth);
    }
  }

  void _refreshFiles() {
    // In a real implementation, this would refresh the file list
    final snackBar = SnackBar(
      content: const Text('File list refreshed'),
      duration: const Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addFile() {
    // In a real implementation, this would show a dialog to add a new file
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose file type:'),
            RadioListTile(
              title: const Text('C File'),
              value: '.c',
              groupValue: '.c',
              onChanged: (value) {},
            ),
            RadioListTile(
              title: const Text('Header File'),
              value: '.h',
              groupValue: '.h',
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add the new file
              Navigator.of(context).pop();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _FolderTile extends StatefulWidget {
  final _FileNode node;
  final int depth;

  const _FolderTile({required this.node, required this.depth});

  @override
  State<_FolderTile> createState() => _FolderTileState();
}

class _FolderTileState extends State<_FolderTile> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(
            left: 8.0 + (widget.depth * 16.0),
            right: 8.0,
          ),
          leading: Icon(
            _isExpanded ? Icons.folder_open : Icons.folder,
            color: Colors.yellow[700],
          ),
          title: Text(
            widget.node.name,
            style: const TextStyle(color: Colors.white),
          ),
          dense: true,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          onLongPress: () {
            _showContextMenu(context);
          },
        ),
        if (_isExpanded)
          ...widget.node.children.map(
            (child) => _FileExplorerState()._buildFileNode(child, widget.depth + 1),
          ),
      ],
    );
  }

  void _showContextMenu(BuildContext context) {
    // Show context menu for folder operations
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height + 200,
      ),
      items: [
        const PopupMenuItem(
          value: 'rename',
          child: Text('Rename'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'new_file',
          child: Text('New File'),
        ),
        const PopupMenuItem(
          value: 'new_folder',
          child: Text('New Folder'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _handleMenuSelection(value);
      }
    });
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'rename':
        // Handle rename
        break;
      case 'delete':
        // Handle delete
        break;
      case 'new_file':
        // Handle new file
        break;
      case 'new_folder':
        // Handle new folder
        break;
    }
  }
}

class _FileTile extends StatelessWidget {
  final _FileNode node;
  final int depth;

  const _FileTile({required this.node, required this.depth});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color? iconColor;

    if (node.name.endsWith('.c')) {
      icon = Icons.description;
      iconColor = Colors.blue;
    } else if (node.name.endsWith('.h')) {
      icon = Icons.description;
      iconColor = Colors.yellow;
    } else {
      icon = Icons.description;
      iconColor = Colors.grey;
    }

    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 8.0 + (depth * 16.0),
        right: 8.0,
      ),
      leading: Icon(icon, color: iconColor),
      title: Text(
        node.name,
        style: const TextStyle(color: Colors.white),
      ),
      dense: true,
      onTap: () {
        _openFile(context);
      },
      onLongPress: () {
        _showContextMenu(context);
      },
    );
  }

  void _openFile(BuildContext context) {
    // In a real implementation, this would open the file in the editor
    final snackBar = SnackBar(
      content: Text('Opening ${node.name}'),
      duration: const Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showContextMenu(BuildContext context) {
    // Show context menu for file operations
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height + 150,
      ),
      items: [
        const PopupMenuItem(
          value: 'rename',
          child: Text('Rename'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'duplicate',
          child: Text('Duplicate'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _handleMenuSelection(value);
      }
    });
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'rename':
        // Handle rename
        break;
      case 'delete':
        // Handle delete
        break;
      case 'duplicate':
        // Handle duplicate
        break;
    }
  }
}

enum _FileType { file, folder }

class _FileNode {
  final String name;
  final _FileType type;
  final List<_FileNode> children;

  _FileNode({
    required this.name,
    required this.type,
    this.children = const [],
  });
}