enum Role { citizen, undercover }

class Player {
  final int id;
  String name;
  Role? role;
  String? word;
  bool isEliminated;

  Player({required this.id, this.name = '', this.role, this.word, this.isEliminated = false});
}
