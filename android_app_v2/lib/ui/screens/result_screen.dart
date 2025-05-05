import 'package:flutter/material.dart';
import '../../data/providers/game_provider.dart';
import 'game_room_screen.dart';
import 'home_setup_screen.dart';

// Result screen with following properties:
// 1. Display the result after checking win conditions
// 2. A button to
//    - Start new game with navigation to home setup screen if the win conditions are met
//    - Navigate back to game room if win conditions are not met
class ResultScreen extends StatelessWidget {
  final GameProvider gameProvider;

  const ResultScreen({required this.gameProvider, super.key});

  @override
  Widget build(BuildContext context) {
    final isGameOver = gameProvider.gameOver;
    final resultText = isGameOver
        ? (gameProvider.winner == 'Undercover'
        ? 'The infiltrator wins!'
        : 'The citizens win!')
        : 'Proceed to the next round, the infiltrator is still among you.';

    final buttonText = isGameOver ? 'Start a new game' : 'Proceed to game';
    final destination = isGameOver ? HomeSetupScreen() : GameRoomScreen() ;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display result
              Text(
                resultText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),

              const SizedBox(height: 40),

              // A button to navigate back to game or start new game
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (isGameOver) {
                    gameProvider.resetGame();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomeSetupScreen()),
                          (route) => false, // This removes all previous routes
                    );
                  } else {
                    gameProvider.resetVotes();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => destination),
                    );
                  }
                },
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
