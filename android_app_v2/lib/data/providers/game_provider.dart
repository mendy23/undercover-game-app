import 'dart:math';
import 'package:flutter/material.dart';
import '../core/word_pairs.dart';
import '../models/player.dart';

class GameProvider with ChangeNotifier {
  List<Player> players = [];

  late List<String> chosenPair;
  bool gameOver = false;
  String winner = '';
  int numberOfPlayer = 3;

  void setPlayers(int count) {
    numberOfPlayer = count;
    players = List.generate(count, (index) => Player(id: index));
    notifyListeners();
  }

  void assignRolesAndWords() {
    final random = Random();
    int undercoverIndex = random.nextInt(players.length);
    chosenPair = WordPairs.getRandomPair(random);

    for (var i = 0; i < players.length; i++) {
      players[i].role = i == undercoverIndex ? Role.undercover : Role.citizen;
      players[i].word = i == undercoverIndex ? chosenPair[1] : chosenPair[0];
    }
    notifyListeners();
  }

  void addVote(int playerId) {
    players.firstWhere((p) => p.id == playerId).votes++;
    notifyListeners();
  }

  void checkWinCondition() {
    int aliveUndercovers = players.where((p) => !p.isEliminated && p.role == Role.undercover).length;
    int totalAlive = players.where((p) => !p.isEliminated).length;

    // Case 1: Citizens win
    if (aliveUndercovers == 0) {
      winner = 'Citizens';
      gameOver = true;
    // Case 2: Undercover wins
    } else if (totalAlive == 2 && aliveUndercovers == 1) {
      winner = 'Undercover';
      gameOver = true;
    // Case 3: Winning conditions are not met
    } else {
      winner = '';
      gameOver = false;
    }
  }

  void checkVotingResult() {
    int maxVotes = players.map((p) => p.votes).reduce(max);

    final mostVotedPlayers = players
        .where((p) => p.votes == maxVotes && !p.isEliminated)
        .toList();

    // Eliminate player with most votes
    if (mostVotedPlayers.length == 1) {
      mostVotedPlayers.first.isEliminated = true;
    }

    checkWinCondition();
    notifyListeners();
  }

  void resetVotes() {
    for (var player in players) {
      player.votes = 0;
    }
    notifyListeners();
  }

  void resetGame() {
    resetVotes();
    players.clear();
    gameOver = false;
    winner = '';
    notifyListeners();
  }

}
