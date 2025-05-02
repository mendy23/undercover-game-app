import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import '../components/player_tile.dart';
import 'voting_screen.dart';

class GameRoomScreen extends StatelessWidget {
  const GameRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Describe Your Word')),
      body: Stack(
        children: [
          Wrap(
            children: provider.players.map((p) => PlayerTile(player: p)).toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const VotingScreen()));
              },
              child: const Text('Proceed to Voting'),
            ),
          )
        ],
      ),
    );
  }
}
