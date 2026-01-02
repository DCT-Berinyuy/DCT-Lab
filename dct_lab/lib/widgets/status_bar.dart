import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildStatusItem(context, Icons.terminal, 'Ready'),
              _buildStatusItem(context, Icons.error, '0 Errors'),
              _buildStatusItem(context, Icons.warning, '1 Warning'),
            ],
          ),
          Row(
            children: [
              _buildStatusItem(context, null, 'Line 18, Col 13'),
              _buildStatusItem(context, null, 'UTF-8'),
              _buildStatusItem(context, null, 'C++17'),
              _buildStatusItem(context, Icons.wifi_off, 'Offline Mode'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, IconData? icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white, size: 16),
          if (icon != null) const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}