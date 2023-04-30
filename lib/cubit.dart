import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //counter cubit can be accessed anywhere throughout the material app
    return BlocProvider(
      create: (BuildContext context) {
        return CounterCubit();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const MyCubit(title: 'BLoC/Cubit State Management'),
      ),
    );
  }
}

class MyCubit extends StatefulWidget {
  const MyCubit({super.key, required this.title});
  final String title;

  @override
  State<MyCubit> createState() => _MyCubit();
}

class _MyCubit extends State<MyCubit> {
  final CounterCubit _cubit = CounterCubit();

  //call the increment function from the cubit to change state
  void _incrementCounter() {
    // _cubit.increment();
    final CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);
    counterCubit.increment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            //listens to state action to carry out a function
            BlocListener<CounterCubit, int>(
              //will only listen when number is a multiple of 5
              listenWhen: (int prevState, int newState) {
                return newState % 5 == 0;
              },
              //shows snack bar when listenWhen condition met
              listener: (BuildContext context, state) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('REEEEEEEEEE')));
              },
              child: BlocBuilder<CounterCubit, int>(
                //provide the local bloc instance
                bloc: BlocProvider.of<CounterCubit>(context),
                //rebuild state when new counter is odd number based off the new state
                //will only rebuild and show odd numbers
                buildWhen: (preState, newState) {
                  return newState % 2 != 0;
                },
                builder: (BuildContext context, int counter) {
                  return Text(
                    '$counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_reaction),
      ),
    );
  }
}

class CounterCubit extends Cubit<int> {
  //define initial state using constructor
  CounterCubit() : super(0); //set initial state as 0

  //new function defined inside cubit and state emitted using emit
  // void increment() {
  //   final int currentState = state;
  //   final int newState = currentState + 1;
  //   emit(newState);
  // }

  // V alternative way of writing the increment function
  void increment() => emit(state + 1);
}
