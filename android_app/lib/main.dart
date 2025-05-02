import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/providers/game_provider.dart';
import 'ui/screens/player_setup_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: const UndercoverApp(),
    ),
  );
}

class UndercoverApp extends StatelessWidget {
  const UndercoverApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Undercover Game',
      theme: ThemeData.dark(),
      home: const PlayerSetupScreen(),
    );
  }
}
