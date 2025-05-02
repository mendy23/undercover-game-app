import 'package:flutter/material.dart';
import '../../data/models/player.dart';

class PlayerTile extends StatelessWidget {
  final Player player;

  const PlayerTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: Column(
        children: [
          Icon(Icons.person, size: 40, color: player.isEliminated ? Colors.grey : Colors.blue),
          Text(player.name.isNotEmpty ? player.name : 'Player ${player.id + 1}'),
        ],
      ),
    );
  }
}
