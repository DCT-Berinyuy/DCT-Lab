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