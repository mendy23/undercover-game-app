import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import 'role_word_distribution_screen.dart';
import '../components/player_count_selector.dart';

// A screen for setting the number of player for the game
class HomeSetupScreen extends StatefulWidget {
  const HomeSetupScreen({super.key});

  @override
  State<HomeSetupScreen> createState() => _HomeSetupScreen();
}

class _HomeSetupScreen extends State<HomeSetupScreen> {
  int playerCount = 3;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Undercover Game Setup')),
      body: Column(
        children: [
          const Text(
            'Please select number of players',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          PlayerCountSelector(
            value: playerCount,
            onChanged: (newCount) {
              setState(() {
                playerCount = newCount;
              });
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              provider.setPlayers(playerCount);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoleWordDistributionScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text('Start Game', style: TextStyle(fontSize: 18)),
            ),
          ),

        ],
      )
    );
  }
}


