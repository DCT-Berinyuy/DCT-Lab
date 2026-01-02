import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.folder),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.smart_toy),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.extension),
            color: Colors.grey,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}