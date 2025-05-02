import 'dart:math';
import 'package:flutter/material.dart';
import '../models/player.dart';

class GameProvider with ChangeNotifier {
  List<Player> players = [];
  final List<List<String>> wordPairs = [
    ['Cat', 'Tiger'],
    ['Coffee', 'Tea'],
    ['Ship', 'Boat'],
  ];

  late List<String> chosenPair;
  bool gameOver = false;
  String winner = '';

  void setPlayers(int count) {
    players = List.generate(count, (index) => Player(id: index));
    notifyListeners();
  }

  void assignRolesAndWords() {
    final random = Random();
    int undercoverIndex = random.nextInt(players.length);
    chosenPair = wordPairs[random.nextInt(wordPairs.length)];

    for (var i = 0; i < players.length; i++) {
      players[i].role = i == undercoverIndex ? Role.undercover : Role.citizen;
      players[i].word = i == undercoverIndex ? chosenPair[1] : chosenPair[0];
    }
    notifyListeners();
  }

  void eliminatePlayer(int id) {
    players.firstWhere((p) => p.id == id).isEliminated = true;
    checkWinCondition();
    notifyListeners();
  }

  void checkWinCondition() {
    int aliveCitizens = players.where((p) => !p.isEliminated && p.role == Role.citizen).length;
    int aliveUndercovers = players.where((p) => !p.isEliminated && p.role == Role.undercover).length;

    if (aliveUndercovers == 0) {
      winner = 'Citizens';
      gameOver = true;
    } else if (aliveCitizens <= 1) {
      winner = 'Undercover';
      gameOver = true;
    }
  }

  void resetGame() {
    players.clear();
    gameOver = false;
    winner = '';
    notifyListeners();
  }
}
