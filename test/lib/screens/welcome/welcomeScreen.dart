import 'package:flutter/material.dart';
import 'package:test/screens/welcome/components/bbody.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bbody());
  }
}