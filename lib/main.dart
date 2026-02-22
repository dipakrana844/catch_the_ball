import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/game/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure game is run in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const CatchTheBallGame());
  });
}

class CatchTheBallGame extends StatelessWidget {
  const CatchTheBallGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catch the Ball',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const StartScreen(),
    );
  }
}
