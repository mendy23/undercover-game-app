import 'package:flutter/material.dart';
import '../../data/models/player.dart';

// Player card is a UI component that prompts action of a player with the following properties:
// 1. Player's name as title
// 2. Dynamic content
// 3. Dynamic button
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
    return Center(
      child: Card(
        color: Colors.grey[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Container(
          width: 300,
          height: 600,
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  player.name.isNotEmpty ? player.name : 'Player ${player.id + 1}',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 16),
                content,
                const SizedBox(height: 16),
                if (onButtonPressed != null)
                  ElevatedButton(onPressed: onButtonPressed, child: Text(buttonText)),
              ],
            ),
          ),
        )
      ),
    );
  }
}
