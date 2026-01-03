import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/gama_service.dart';

class GameViewport extends StatefulWidget {
  const GameViewport({super.key});

  @override
  State<GameViewport> createState() => _GameViewportState();
}

class _GameViewportState extends State<GameViewport> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GamaService>(
      builder: (context, gamaService, child) {
        if (gamaService.framebuffer.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Image.memory(
            gamaService.framebuffer,
            gaplessPlayback: true,
          );
        }
      },
    );
  }
}
