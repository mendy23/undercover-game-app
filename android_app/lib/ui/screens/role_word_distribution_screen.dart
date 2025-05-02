import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import '../components/player_card.dart';
import 'game_room_screen.dart';

class RoleWordDistributionScreen extends StatefulWidget {
  const RoleWordDistributionScreen({super.key});

  @override
  State<RoleWordDistributionScreen> createState() => _RoleDistributionScreenState();
}

class _RoleDistributionScreenState extends State<RoleWordDistributionScreen> {
  int currentIndex = 0;
  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final player = provider.players[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Role Distribution')),
      body: Center(
        child: PlayerCard(
          player: player,
          content: revealed
              ? Text('Your word: ${player.word}', style: const TextStyle(fontSize: 24))
              : const Text('Tap to reveal your word'),
          buttonText: revealed
              ? (currentIndex == provider.players.length - 1 ? 'Proceed' : 'Next Player')
              : 'Reveal',
          onButtonPressed: () {
            setState(() {
              if (!revealed) {
                revealed = true;
              } else {
                if (currentIndex < provider.players.length - 1) {
                  currentIndex++;
                  revealed = false;
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameRoomScreen()));
                }
              }
            });
          },
        ),
      ),
    );
  }
}
