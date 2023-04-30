// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_listview/teaminfo.dart';
import 'person.dart';

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
        primarySwatch: Colors.indigo,
      ),
      home: const Mobile(title: 'Mobile Team'),
    );
  }
}

class Mobile extends StatefulWidget {
  const Mobile({super.key, required this.title});

  final String title;

  @override
  State<Mobile> createState() => _Mobile();
}

class _Mobile extends State<Mobile> {
  List teamInfo = [];

  Future<void> loadData() async {
    final String response =
        await rootBundle.loadString('assets/team_info.json');
    final person_data = await json.decode(response);
    setState(() {
      teamInfo = person_data['team_info'];
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: teamInfo.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Person(
                            age: teamInfo[index]['age'],
                            country: teamInfo[index]['country'],
                            description: teamInfo[index]['description'],
                            name: teamInfo[index]['name'],
                          )));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: Hero(
                          tag: teamInfo[index]['name'],
                          child: Image.asset(
                              'assets/people/${teamInfo[index]['name']}.png'),
                        ),
                      ),
                    ),
                    Text(
                      teamInfo[index]['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 90,
                          color: Colors.indigo.withOpacity(0.8)),
                    ),
                    // Text(
                    //   teamInfo[index]['name'],
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 90,
                    //       color: Colors.indigo.withOpacity(0.5)),
                    // )
                  ],
                ),
              ),
              // ElevatedButton(
              //   child: Text(_teamInfo[index]['name']),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const Person(
              //                 title: 'Person',
              //               )),
              //     );
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}

//wrap widget in Hero() with same tags to add transition effects between pages