import 'package:flutter/material.dart';

class ResizableSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double initialLeftWidth;

  const ResizableSplitView({
    super.key,
    required this.left,
    required this.right,
    this.initialLeftWidth = 300.0,
  });

  @override
  State<ResizableSplitView> createState() => _ResizableSplitViewState();
}

class _ResizableSplitViewState extends State<ResizableSplitView> {
  late ValueNotifier<double> _leftWidth;

  @override
  void initState() {
    super.initState();
    _leftWidth = ValueNotifier(widget.initialLeftWidth);
  }

  @override
  void dispose() {
    _leftWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ValueListenableBuilder<double>(
          valueListenable: _leftWidth,
          builder: (context, leftWidth, child) {
            return Row(
              children: [
                SizedBox(
                  width: leftWidth,
                  child: widget.left,
                ),
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final newWidth = leftWidth + details.delta.dx;
                    if (newWidth > 100 && newWidth < constraints.maxWidth - 100) {
                      _leftWidth.value = newWidth;
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: Container(
                      width: 4.0,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                Expanded(
                  child: widget.right,
                ),
              ],
            );
          },
        );
      },
    );
  }
}