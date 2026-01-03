import 'package:flutter/foundation.dart';
import '../models/project_model.dart';

enum ProjectType { cpp, gama }

class ProjectProvider extends ChangeNotifier {
  final List<Project> _projects = [
    Project(
      name: 'Space Shooter 3000',
      path: '/path/to/space_shooter',
      mainFile: 'main.cpp',
      type: ProjectType.cpp,
    ),
    Project(
      name: 'Forest Platformer',
      path: '/path/to/forest_platformer',
      mainFile: 'main.cpp',
      type: ProjectType.cpp,
    ),
    Project(
      name: 'Physics Engine V2',
      path: '/path/to/physics_engine',
      mainFile: 'main.c',
      type: ProjectType.cpp,
    ),
    Project(
      name: 'Menu System',
      path: '/path/to/menu_system',
      mainFile: 'main.cpp',
      type: ProjectType.cpp,
    ),
    Project(
      name: 'Gama Game Project',
      path: '/path/to/gama_project',
      mainFile: 'main.c',
      type: ProjectType.gama,
    ),
  ];

  List<Project> get projects => _projects;

  Project? _currentProject;
  Project? get currentProject => _currentProject;

  ProjectType get currentProjectType => _currentProject?.type ?? ProjectType.cpp;

  void createNewProject(String name, String path, ProjectType type) {
    final newProject = Project.createNew(name, path, type: type);
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

  void updateCurrentProjectType(ProjectType type) {
    if (_currentProject != null) {
      _currentProject!.type = type;
      notifyListeners();
    }
  }
}