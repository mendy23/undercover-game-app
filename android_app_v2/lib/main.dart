import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/providers/game_provider.dart';
import 'ui/screens/home_setup_screen.dart';

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
      theme: ThemeData.light(),
      home: WillPopScope(
        onWillPop: () async => false, // Disable back button
        child: const HomeSetupScreen(),
      ),
    );
  }
}
