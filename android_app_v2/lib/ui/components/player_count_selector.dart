import 'package:flutter/material.dart';
import '../../core/game_config.dart';

// Player count selector is a UI component which users can set the number of players for the game
class PlayerCountSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const PlayerCountSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = GameConfig.minPlayer,
    this.max = GameConfig.maxPLayer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // '-' Button to reduce the number of player
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: value > min ? () => onChanged(value - 1) : null,
          color: value > min ? Colors.blue : Colors.grey,
        ),

        // Display of selected the selected number
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$value',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        // '+' Button to increase the number of player
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: value < max ? () => onChanged(value + 1) : null,
          color: value < max ? Colors.blue : Colors.grey,
        ),
      ],
    );
  }
}