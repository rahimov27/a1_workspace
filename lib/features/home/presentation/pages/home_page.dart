import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Hello",
          style: TextStyle(
            fontSize: 30,
            fontFamily: "sf",
          ),
        ),
      ),
    );
  }
}
