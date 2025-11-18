import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF4F2F2),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'To',
                  style: TextStyle(
                    fontFamily: 'TitanOne',
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF78BF32),
                    height: 0.8,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Do',
                  style: TextStyle(
                    fontFamily: 'TitanOne',
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF78BF32),
                    height: 0.8,
                  ),
                ),
                const SizedBox(height: 40),
                const Icon(
                  Icons.check_circle,
                  size: 100,
                  color: Color(0xFF78BF32),
                ),
                const SizedBox(height: 20),
                const Text(
                  '¡Verificación exitosa!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bienvenido a la plataforma To Do',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}