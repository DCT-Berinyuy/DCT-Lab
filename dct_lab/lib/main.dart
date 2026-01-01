import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/code_editor_provider.dart';
import 'screens/advanced_code_editor_screen.dart';

void main() {
  runApp(const DctLabApp());
}

class DctLabApp extends StatelessWidget {
  const DctLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CodeEditorProvider()),
      ],
      child: MaterialApp(
        title: 'DCT Lab - C/C++ Learning IDE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DCT Lab - C/C++ Learning IDE'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text(
          'Welcome to DCT Lab - Your Offline C/C++ Learning Environment',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'DCT Lab',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('New Project'),
              leading: const Icon(Icons.create_new_folder),
              onTap: () {
                // Navigate to new project screen
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdvancedCodeEditorScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Open Project'),
              leading: const Icon(Icons.folder_open),
              onTap: () {
                // Navigate to open project screen
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdvancedCodeEditorScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Templates'),
              leading: const Icon(Icons.extension),
              onTap: () {
                // Navigate to templates screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}