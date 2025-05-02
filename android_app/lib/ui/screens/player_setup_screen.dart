import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import '../components/player_card.dart';
import 'role_word_distribution_screen.dart';

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  int playerCount = 3;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Player Setup')),
      body: Column(
        children: [
          Slider(
            min: 3,
            max: 12,
            divisions: 9,
            label: '$playerCount players',
            value: playerCount.toDouble(),
            onChanged: (val) {
              setState(() {
                playerCount = val.toInt();
                provider.setPlayers(playerCount);
              });
            },
          ),
          Expanded(
            child: ListView(
              children: provider.players.map((player) {
                return PlayerCard(
                  player: player,
                  content: TextField(
                    decoration: const InputDecoration(hintText: "Enter name"),
                    onChanged: (val) {
                      player.name = val;
                    },
                  ),
                  buttonText: '',
                  onButtonPressed: null,
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.assignRolesAndWords();
              Navigator.push(context, MaterialPageRoute(builder: (_) => RoleWordDistributionScreen()));
            },
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }
}
