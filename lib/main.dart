import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/photo_provider.dart';
import 'screens/photo_grid_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PhotoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CloudWalk Photo Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhotoGridScreen(),
    );
  }
}