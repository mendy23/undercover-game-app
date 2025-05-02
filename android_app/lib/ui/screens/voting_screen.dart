import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/player_card.dart';
import 'result_screen.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Vote Out a Player')),
      body: ListView(
        children: provider.players.where((p) => !p.isEliminated).map((player) {
          return PlayerCard(
            player: player,
            content: const SizedBox.shrink(),
            buttonText: 'Vote',
            onButtonPressed: () {
              provider.eliminatePlayer(player.id);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
            },
          );
        }).toList(),
      ),
    );
  }
}
