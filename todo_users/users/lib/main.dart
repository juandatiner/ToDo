import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _playSound();
  runApp(const MyApp());
}


Future<void> _playSound() async {
  final player = AudioPlayer();
  await player.play(AssetSource('sounds/entrada.mp3'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF4F2F2),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF78BF32)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
