class Project {
  String name;
  String path;
  String mainFile;
  List<String> files;
  bool isSaved;

  Project({
    required this.name,
    required this.path,
    required this.mainFile,
    this.files = const [],
    this.isSaved = false,
  });

  // Create a new project
  static Project createNew(String projectName, String projectPath) {
    return Project(
      name: projectName,
      path: projectPath,
      mainFile: 'main.c',
      files: ['main.c'],
      isSaved: false,
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
    };
  }

  // Create from JSON
  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      path: json['path'] ?? '',
      mainFile: json['mainFile'] ?? 'main.c',
      files: List<String>.from(json['files'] ?? []),
      isSaved: json['isSaved'] ?? false,
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