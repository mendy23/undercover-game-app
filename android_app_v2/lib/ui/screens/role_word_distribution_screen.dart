import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import '../components/player_tile.dart';
import 'game_room_screen.dart';
import '../../data/models/player.dart';
import '../components/player_card.dart';

// A screen for saving players' names and distributing roles and words
// It consists of the following:
// 1. A background with player grid
// 2. Floating player cards for entering name and revealing roles and words to individual players
//    ** name is a required field
// 3. A button to navigate to game room screen
class RoleWordDistributionScreen extends StatefulWidget {
  const RoleWordDistributionScreen({super.key});

  @override
  State<RoleWordDistributionScreen> createState() => _RoleWordDistributionScreenState();
}

class _RoleWordDistributionScreenState extends State<RoleWordDistributionScreen> {
  int _currentPlayerIndex = 0;
  final TextEditingController _nameController = TextEditingController();
  bool _showCard = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameProvider>(context, listen: false).assignRolesAndWords();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleNameSubmit(Player player) {
    final enteredName = _nameController.text.trim();
    if (enteredName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Please enter a name',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
      );
      return;
    }

    setState(() {
      player.name = enteredName;
      _nameController.clear();
    });
  }

  void _nextPlayer() async {
    setState(() => _showCard = false);
    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      if (_currentPlayerIndex < Provider.of<GameProvider>(context, listen: false).numberOfPlayer - 1) {
        _currentPlayerIndex++;
        _showCard = true; // animate open
      } else {
        _currentPlayerIndex = -1; // hide card
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final players = provider.players;

    final currentPlayer = _currentPlayerIndex >= 0 ? players[_currentPlayerIndex] : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Role Distribution')),
      body: Stack(
        children: [
          Column(
            children: [
              Text(
                '${provider.numberOfPlayer} Players',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

              // Start Game Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: _currentPlayerIndex == -1
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameRoomScreen(),
                      ),
                    );
                  }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Start the party!', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),

          if (currentPlayer != null)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _showCard
                  ? PlayerCard(
                key: ValueKey(currentPlayer.id),
                player: currentPlayer,
                content: currentPlayer.name == 'Unknown'
                    ? Column(
                  children: [
                    const Text('Please insert your name', style: TextStyle(color: Colors.black)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Player ${_currentPlayerIndex + 1}',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    Text(
                      'You are ${currentPlayer.role?.name}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Your word is: ${currentPlayer.word}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                buttonText: currentPlayer.name == 'Unknown' ? 'Enter' : 'OK',
                onButtonPressed: () {
                  if (currentPlayer.name == 'Unknown') {
                    _handleNameSubmit(currentPlayer);
                  } else {
                    _nextPlayer();
                  }
                },
              )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
