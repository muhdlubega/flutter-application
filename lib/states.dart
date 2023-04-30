import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const States(title: 'Flutter State Management'),
    );
  }
}

class States extends StatefulWidget {
  const States({super.key, required this.title});

  final String title;

  @override
  State<States> createState() => _MyStates();
}

class _MyStates extends State<States> {
  @override
  Widget build(BuildContext context) {
    bool _pressed = false;
    var color =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press Me!',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, color: color),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _pressed = true;
                });
              },
              child: Container(
                color: color,
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
