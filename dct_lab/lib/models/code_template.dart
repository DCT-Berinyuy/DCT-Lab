class CodeTemplate {
  final String name;
  final String description;
  final String code;
  final String fileName;
  final String category; // New field

  CodeTemplate({
    required this.name,
    required this.description,
    required this.code,
    this.fileName = 'main.c',
    this.category = 'General', // Default category
  });

  static List<CodeTemplate> getTemplates() {
    return [
      CodeTemplate(
        name: 'Hello World',
        description: 'A simple Hello World program',
        code: '''#include <stdio.h>

int main() {
    printf("Hello, World!\\n");
    return 0;
}''',
        category: 'Fundamentals',
      ),
      CodeTemplate(
        name: 'Simple Calculator',
        description: 'A basic calculator that adds two numbers',
        code: '''#include <stdio.h>

int main() {
    double num1, num2, result;
    
    printf("Simple Calculator\\n");
    printf("Enter first number: ");
    scanf("%lf", &num1);
    
    printf("Enter second number: ");
    scanf("%lf", &num2);
    
    result = num1 + num2;
    
    printf("%.2lf + %.2lf = %.2lf\\n", num1, num2, result);
    
    return 0;
}''',
        category: 'Fundamentals',
      ),
      CodeTemplate(
        name: 'Loop Example',
        description: 'Demonstrates for and while loops',
        code: '''#include <stdio.h>

int main() {
    printf("For loop example:\\n");
    for (int i = 0; i < 5; i++) {
        printf("Iteration: %d\\n", i);
    }
    
    printf("\\nWhile loop example:\\n");
    int count = 0;
    while (count < 5) {
        printf("Count: %d\\n", count);
        count++;
    }
    
    return 0;
}''',
        category: 'Fundamentals',
      ),
      CodeTemplate(
        name: 'Gama Engine Template',
        description: 'Basic template for Gama Engine integration',
        code: '''#include <gama.h>

int main() {
    gm_init(800, 600, "Gama Engine Example");
    gm_background(GM_WHITE);
    
    while(gm_yield()) {
        // Draw a simple shape
        gm_draw_rectangle(0, 0, 0.2, 0.2, GM_RED);
        
        // Add your game logic here
    }
    
    return 0;
}''',
        category: 'Game Development',
      ),
    ];
  }
  
  static CodeTemplate? getTemplateByName(String name) {
    try {
      return getTemplates().firstWhere((template) => template.name == name);
    } catch (e) {
      return null;
    }
  }
}