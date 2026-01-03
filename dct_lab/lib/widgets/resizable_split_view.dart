import 'package:flutter/material.dart';

class ResizableSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double initialLeftWidth;

  const ResizableSplitView({
    super.key,
    required this.left,
    required this.right,
    this.initialLeftWidth = 600.0,
  });

  @override
  State<ResizableSplitView> createState() => _ResizableSplitViewState();
}

class _ResizableSplitViewState extends State<ResizableSplitView> {
  late ValueNotifier<double> _leftWidth;

  @override
  void initState() {
    super.initState();
    // Calculate initial left width as 65% of available width to give more space to the editor
    // We'll calculate this when the layout is built, but for now use a larger default
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
            // Calculate the right width based on available space
            double rightWidth = constraints.maxWidth - leftWidth - 4.0; // 4.0 is divider width

            return Row(
              children: [
                SizedBox(
                  width: leftWidth,
                  child: widget.left,
                ),
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final newWidth = leftWidth + details.delta.dx;
                    if (newWidth > 200 && newWidth < constraints.maxWidth - 200) {
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
                SizedBox(
                  width: rightWidth,
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