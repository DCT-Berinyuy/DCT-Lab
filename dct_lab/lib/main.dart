import 'package:dct_lab/providers/gama_service.dart';
import 'package:dct_lab/screens/advanced_code_editor_screen.dart';
import 'package:dct_lab/screens/templates_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/build_and_run_service.dart';
import 'providers/code_editor_provider.dart';
import 'providers/project_provider.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const DctLabApp());
}

class DctLabApp extends StatelessWidget {
  const DctLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CodeEditorProvider()),
        ChangeNotifierProvider(create: (_) => BuildAndRunService()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => GamaService()),
      ],
      child: MaterialApp(
        title: 'DCT Lab - C/C++ & Gama Engine IDE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF2b7cee),
          scaffoldBackgroundColor: const Color(0xFF111418),
          cardColor: const Color(0xFF1e242d),
          textTheme: GoogleFonts.lexendTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF111418),
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF2b7cee),
            background: Color(0xFF111418),
            surface: Color(0xFF1e242d),
          ),
        ),
        themeMode: ThemeMode.dark, // Enforce dark mode for now
        home: const TemplatesScreen(),
        routes: {
          '/templates': (context) => TemplatesScreen(),
          '/editor': (context) => AdvancedCodeEditorScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}