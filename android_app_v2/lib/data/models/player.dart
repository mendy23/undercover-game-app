enum Role {
  citizen,
  undercover
}

class Player {
  final int id;
  String name;
  Role? role;
  String? word;
  bool isEliminated;
  int votes;

  Player({required this.id, this.name = 'Unknown', this.role, this.word, this.isEliminated = false, this.votes = 0});
}
