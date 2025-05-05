import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import '../components/player_tile.dart';
import 'voting_screen.dart';
import '../../data/models/player.dart';

// A game room with following properties:
// 1. Instruction of the game
// 2. Display remaining number of infiltrators
// 3. Player grid that displays the status of players (Eliminated or alive)
// 3. A button to navigate to voting screen
class GameRoomScreen extends StatelessWidget {
  const GameRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Game Room')),
      body: Column(
        children: [
          // Instruction Text
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber),
            ),
            child: const Text(
              'Each player please describe your word without mentioning the word. Then, click the button to move to the voting phase.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 40),

          // Infiltrators Count Box
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red),
            ),
            child: Text(
              'The infiltrator is still among you!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Player grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(20),
              itemCount: provider.numberOfPlayer,
              itemBuilder: (context, index) {
                final player = provider.players[index];
                return PlayerTile(player: player);
              },
            ),
          ),

          // Vote Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VotingScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                'Vote Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}