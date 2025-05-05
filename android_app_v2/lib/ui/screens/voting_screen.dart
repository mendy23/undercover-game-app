import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/game_provider.dart';
import '../components/player_tile.dart';
import 'result_screen.dart';
import '../components/player_card.dart';

// Voting screen with the following properties:
// 1. PLayer grid that display the votes of players
// 2. Floating player cards for individual players to vote
// 3. A button to check the result after voting phase
class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  int _currentVoterIndex = 0;
  bool _showCard = true;
  int? _selectedPlayerToVoteFor;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameProvider>(context, listen: false).resetVotes();
    });
  }

  void _nextVoter() async {
    setState(() => _showCard = false);
    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      if (_currentVoterIndex < Provider.of<GameProvider>(context, listen: false).numberOfPlayer - 1) {
        _currentVoterIndex++;
        _showCard = true;
        _selectedPlayerToVoteFor = null;
      } else {
        _currentVoterIndex = -1;
      }
    });
  }

  void _handleVote(int votedPlayerId) {
    setState(() {
      _selectedPlayerToVoteFor = votedPlayerId;
    });

    Provider.of<GameProvider>(context, listen: false).addVote(votedPlayerId);

    Future.delayed(const Duration(milliseconds: 600), () {
      _nextVoter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final players = provider.players;
    final currentVoter = _currentVoterIndex >= 0 ? players[_currentVoterIndex] : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Voting Time')),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Vote for the Undercover',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return PlayerTile(
                      player: player,
                      votes: player.votes,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _currentVoterIndex == -1
                      ? () {
                    provider.checkVotingResult();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          gameProvider: Provider.of<GameProvider>(context, listen: false),
                        ),
                      ),
                    );
                  }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Check the result', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),

          // Floating player card
          if (currentVoter != null)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: _showCard
                  ? PlayerCard(
                key: ValueKey(currentVoter.id),
                player: currentVoter,
                content: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Who do you want to vote?',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        ...players
                            .where((p) => p.id != currentVoter.id)
                            .map((player) {
                          final isSelected = _selectedPlayerToVoteFor == player.id;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? Colors.green : Colors.grey[800],
                                foregroundColor: Colors.white,
                                minimumSize: const Size(220, 50),
                              ),
                              onPressed: () => _handleVote(player.id),
                              child: Text(
                                player.name.isNotEmpty ? player.name : 'Player ${player.id + 1}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),

                buttonText: 'Skip',
                onButtonPressed: _nextVoter,
              )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
