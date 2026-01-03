import '../providers/project_provider.dart';

class Project {
  String name;
  String path;
  String mainFile;
  List<String> files;
  bool isSaved;
  ProjectType type;

  Project({
    required this.name,
    required this.path,
    required this.mainFile,
    this.files = const [],
    this.isSaved = false,
    this.type = ProjectType.cpp,
  });

  // Create a new project
  static Project createNew(String projectName, String projectPath, {ProjectType type = ProjectType.cpp}) {
    String defaultMainFile = type == ProjectType.gama ? 'main.c' : 'main.c';
    String defaultFile = type == ProjectType.gama ? 'main.c' : 'main.c';

    return Project(
      name: projectName,
      path: projectPath,
      mainFile: defaultMainFile,
      files: [defaultFile],
      isSaved: false,
      type: type,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'mainFile': mainFile,
      'files': files,
      'isSaved': isSaved,
      'type': type.toString().split('.').last, // Convert enum to string
    };
  }

  // Create from JSON
  static Project fromJson(Map<String, dynamic> json) {
    String typeStr = json['type'] ?? 'cpp';
    ProjectType projectType = typeStr == 'gama' ? ProjectType.gama : ProjectType.cpp;

    return Project(
      name: json['name'] ?? '',
      path: json['path'] ?? '',
      mainFile: json['mainFile'] ?? 'main.c',
      files: List<String>.from(json['files'] ?? []),
      isSaved: json['isSaved'] ?? false,
      type: projectType,
    );
  }

  // Add a new file to the project
  void addFile(String fileName) {
    if (!files.contains(fileName)) {
      files.add(fileName);
      isSaved = false;
    }
  }

  // Remove a file from the project
  void removeFile(String fileName) {
    files.remove(fileName);
    isSaved = false;
  }

  // Save the project state
  void markSaved() {
    isSaved = true;
  }
}