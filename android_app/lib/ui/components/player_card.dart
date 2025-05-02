import 'package:flutter/material.dart';
import '../models/player.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final Widget content;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const PlayerCard({
    super.key,
    required this.player,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(player.name.isNotEmpty ? player.name : 'Player ${player.id + 1}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          content,
          const SizedBox(height: 10),
          if (onButtonPressed != null)
            ElevatedButton(onPressed: onButtonPressed, child: Text(buttonText)),
        ],
      ),
    );
  }
}
