import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Layout(title: 'My Layout'),
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Layout',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Container(color: Colors.brown)),
                      Expanded(
                          flex: 1, child: Container(color: Colors.deepOrange)),
                      Expanded(flex: 1, child: Container(color: Colors.amber)),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Container(color: Colors.green)),
                      Expanded(flex: 1, child: Container(color: Colors.cyan)),
                      Expanded(flex: 1, child: Container(color: Colors.purple)),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Container(color: Colors.teal)),
                      Expanded(flex: 1, child: Container(color: Colors.lime)),
                    ],
                  )),
              Expanded(flex: 1, child: Container(color: Colors.indigo)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Welcome To My Layout!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FlutterLogo(
                          size: 80,
                        ),
                        FlutterLogo(
                          size: 80,
                        ),
                        FlutterLogo(
                          size: 80,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.favorite,
                          size: 60,
                          color: Colors.red,
                        ),
                        Icon(
                          Icons.star,
                          size: 60,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.thumb_up_rounded,
                          size: 60,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Created by Bega',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
