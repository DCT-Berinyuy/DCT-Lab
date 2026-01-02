import 'package:flutter/material.dart';

class TemplateCard extends StatelessWidget {
  final String name;
  final String description;
  final String difficulty;
  final String category;
  final IconData icon;

  const TemplateCard({
    super.key,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.category,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: Colors.grey[800],
            child: Center(
              child: Icon(icon, size: 48, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  difficulty,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Load Template'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}