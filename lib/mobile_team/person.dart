import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  const Person(
      {super.key,
      required this.name,
      required this.country,
      required this.description,
      required this.age});
  final String name;
  final String country;
  final String description;
  final int age;

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Person Information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Stack(alignment: Alignment.center, children: [
                Hero(
                    tag: widget.name,
                    child: Image.asset("assets/people/${widget.name}.png")),
                Positioned(
                    left: 20,
                    top: 20,
                    child: Image.asset(
                      "assets/countries/${widget.country}.png",
                      scale: 6,
                    )),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 150,
                        color: Colors.indigo),
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  '${widget.age}, ${widget.country}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.indigo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.indigo),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
