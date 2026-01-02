import 'package:flutter/foundation.dart';
import '../models/project_model.dart';

class ProjectProvider extends ChangeNotifier {
  final List<Project> _projects = [
    Project(
      name: 'Space Shooter 3000',
      path: '/path/to/space_shooter',
      mainFile: 'main.cpp',
    ),
    Project(
      name: 'Forest Platformer',
      path: '/path/to/forest_platformer',
      mainFile: 'main.cpp',
    ),
    Project(
      name: 'Physics Engine V2',
      path: '/path/to/physics_engine',
      mainFile: 'main.c',
    ),
    Project(
      name: 'Menu System',
      path: '/path/to/menu_system',
      mainFile: 'main.cpp',
    ),
  ];

  List<Project> get projects => _projects;

  Project? _currentProject;
  Project? get currentProject => _currentProject;

  void createNewProject(String name, String path) {
    final newProject = Project.createNew(name, path);
    _projects.add(newProject);
    _currentProject = newProject;
    notifyListeners();
  }

  void loadProject(Project project) {
    _currentProject = project;
    notifyListeners();
  }

  void saveProject() {
    if (_currentProject != null) {
      _currentProject!.markSaved();
      notifyListeners();
    }
  }
}