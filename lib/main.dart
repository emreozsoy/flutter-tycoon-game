import 'package:flutter/material.dart';

import 'Screens/entry.dart';
import 'Scripts/player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the Player object
    Player player = Player(username: 'Player1');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: EntryScreen(player: player),  // Pass the Player object to EntryScreen
    );
  }
}




