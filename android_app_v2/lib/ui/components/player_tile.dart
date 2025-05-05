import 'package:flutter/material.dart';
import '../../data/models/player.dart';

// PLayer tile is a UI Component that represent a player with the following properties:
// Variant 1: A human icon with color blue (if not eliminated) or grey (if eliminated), and the player name as text
// Variant 2: Same as Variant 1 and with additional vote count display

class PlayerTile extends StatelessWidget {
  final Player player;
  final int? votes;

  const PlayerTile({
    super.key,
    required this.player,
    this.votes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: votes != null ? const EdgeInsets.all(6) : null,
      decoration: votes != null
          ? BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(8),
      )
          : null,
      child: Column(
        // Variant 1 Tile
        children: [
          Icon(
            Icons.person,
            size: 40,
            color: player.isEliminated ? Colors.grey : Colors.blue,
          ),
          Text(player.name.isNotEmpty ? player.name : 'Player ${player.id + 1}'),
          // Conditional variant 2 (used only in voting screen)
          if (votes != null) ...[
            const SizedBox(height: 8),
            _buildVoteBar(votes!),
          ],
        ],
      ),
    );
  }

  Widget _buildVoteBar(int votes) {
    return Stack(
      children: [
        Container(
          height: 20,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
        ),
        FractionallySizedBox(
          widthFactor: votes / 10,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              '$votes vote${votes == 1 ? '' : 's'}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}