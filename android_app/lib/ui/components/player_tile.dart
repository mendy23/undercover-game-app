import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  final String playerName;
  final bool isEliminated;
  final Color activeColor;
  final double size;

  const PlayerTile({
    super.key,
    required this.playerName,
    this.isEliminated = false,
    this.activeColor = Colors.blue,
    this.size = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size + 24, // Extra space for name
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Player Avatar
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isEliminated ? Colors.grey : activeColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              size: size * 0.6,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Player Name
          Text(
            playerName,
            style: TextStyle(
              fontSize: size * 0.15,
              fontWeight: FontWeight.bold,
              color: isEliminated ? Colors.grey : Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Preview method
  static Widget preview() {
    return Scaffold(
      appBar: AppBar(title: const Text('Player Tile Preview')),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            const PlayerTile(
              playerName: "Active Player",
              isEliminated: false,
              activeColor: Colors.blue,
            ),
            const PlayerTile(
              playerName: "Eliminated",
              isEliminated: true,
            ),
            PlayerTile(
              playerName: "Custom Color",
              activeColor: Colors.green,
              size: 100,
            ),
            PlayerTile(
              playerName: "Long Name Example",
              activeColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}