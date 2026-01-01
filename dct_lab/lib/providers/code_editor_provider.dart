import 'package:flutter/foundation.dart';

class CodeEditorProvider extends ChangeNotifier {
  String _code = '';
  
  String get code => _code;
  
  void setCode(String newCode) {
    _code = newCode;
    notifyListeners();
  }
  
  void loadTemplate(String template) {
    _code = template;
    notifyListeners();
  }
  
  void clearCode() {
    _code = '';
    notifyListeners();
  }
}

class ProjectProvider extends ChangeNotifier {
  String _projectName = 'Untitled Project';
  String _projectPath = '';
  bool _isSaved = false;
  
  String get projectName => _projectName;
  String get projectPath => _projectPath;
  bool get isSaved => _isSaved;
  
  void createNewProject(String name) {
    _projectName = name;
    _projectPath = '';
    _isSaved = false;
    notifyListeners();
  }
  
  void saveProject(String path) {
    _projectPath = path;
    _isSaved = true;
    notifyListeners();
  }
  
  void markUnsaved() {
    _isSaved = false;
    notifyListeners();
  }
}