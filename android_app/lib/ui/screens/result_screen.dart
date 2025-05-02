import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'game_room_screen.dart';
import 'player_setup_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Round Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.gameOver ? '${provider.winner} Win!' : 'Next Round', style: const TextStyle(fontSize: 30)),
            ElevatedButton(
              onPressed: () {
                if (provider.gameOver) {
                  provider.resetGame();
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (_) => const PlayerSetupScreen()), (route) => false);
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameRoomScreen()));
                }
              },
              child: Text(provider.gameOver ? 'Restart' : 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
