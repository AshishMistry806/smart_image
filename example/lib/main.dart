import 'package:flutter/material.dart';
import 'package:smart_image/smart_image.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("SmartImage Example")),
        body: Center(
          child: SmartImage(
            imageUrl: "https://picsum.photos/200",
            name: "Ashish Mistry",
            height: 100,
            width: 100,
            useNameAsFallback: true,
            isOnlineBadge: true,
          ),
        ),
      ),
    );
  }
}
