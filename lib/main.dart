import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application/cubit.dart';
import 'package:flutter_application/layout.dart';
import 'package:flutter_application/mobile_team/mobile.dart';
import 'package:flutter_application/states.dart';
import 'package:flutter_application/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return WeatherCubit();
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return CounterCubit();
            },
          ),
        ],
        //MaterialApp() to set default property for the whole application
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: const MyHomePage(),
        ));
  }
}

/// STATELESS WIDGET
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Hello')),
//     );
//   }
// }

/// STATEFUL WIDGET
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool _isMorning = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_isMorning ? 'Good Morning!' : 'Good Night~'),
//         backgroundColor: _isMorning ? Colors.lightBlue : Colors.deepPurple,
//       ),
//       backgroundColor: _isMorning ? Colors.white : Colors.black,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor:
//             _isMorning ? Colors.lightBlueAccent : Colors.deepPurpleAccent,
//         child:
//             Icon(_isMorning ? Icons.nightlight_round : Icons.wb_sunny_rounded),
//         onPressed: () {
//           setState(() {
//             _isMorning = !_isMorning;
//           });
//         },
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isMorning = true;

  @override
  Widget build(BuildContext context) {
    //Scaffold() to set default property for all the widgets inside it
    return Scaffold(
      appBar: AppBar(
        title: Text(_isMorning ? 'Good Morning!' : 'Good Night~'),
        backgroundColor: _isMorning ? Colors.lightBlue : Colors.deepPurple,
      ),
      backgroundColor: _isMorning ? Colors.white : Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isMorning
                ? Visibility(
                    visible: true,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/originals/f6/99/45/f6994503c6a4011c2c5149e54f3374a6.gif",
                      placeholder: (context, url) =>
                          LoadingAnimationWidget.beat(
                              color: Colors.lightBlue, size: 150),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 400,
                    ),
                  )
                : Visibility(
                    visible: true,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/96371cf2-e1cd-48c3-82e8-b851d94a2b77/d286btj-82334ddf-74ce-48f1-b6fc-136dc74db16d.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzk2MzcxY2YyLWUxY2QtNDhjMy04MmU4LWI4NTFkOTRhMmI3N1wvZDI4NmJ0ai04MjMzNGRkZi03NGNlLTQ4ZjEtYjZmYy0xMzZkYzc0ZGIxNmQuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.fZtO3SD90DvHX8srlgTWgGizV4YC56His_Zm3RHveyw",
                      placeholder: (context, url) =>
                          LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.deepPurple, size: 150),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 400,
                    ),
                  ),
            // const SizedBox(
            //   height: 20,
            // ),
            Text(
              'Click on the icon to switch mode:',
              style: (TextStyle(
                  fontSize: 24,
                  color: _isMorning ? Colors.black : Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isMorning = true;
                        });
                      },
                      child: Icon(Icons.wb_sunny_rounded,
                          size: 50,
                          color: _isMorning
                              ? Colors.lightBlueAccent
                              : Colors.deepPurpleAccent)),
                  Text(
                    'Daylight Mode',
                    style: (TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _isMorning ? Colors.black : Colors.white)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isMorning = false;
                        });
                      },
                      child: Icon(Icons.nightlight_round,
                          size: 50,
                          color: _isMorning
                              ? Colors.lightBlueAccent
                              : Colors.deepPurpleAccent)),
                  Text(
                    'Night Mode',
                    style: (TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _isMorning ? Colors.black : Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor:
                      _isMorning ? Colors.lightBlue : Colors.deepPurple),
              child: const Text('Layout'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                            title: 'Layout',
                          )),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor:
                      _isMorning ? Colors.lightBlue : Colors.deepPurple),
              child: const Text('States'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const States(
                            title: 'States',
                          )),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor:
                      _isMorning ? Colors.lightBlue : Colors.deepPurple),
              child: const Text('Cubit'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyCubit(
                            title: 'Cubit',
                          )),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor:
                      _isMorning ? Colors.lightBlue : Colors.deepPurple),
              child: const Text('Weather App'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor:
                      _isMorning ? Colors.lightBlue : Colors.deepPurple),
              child: const Text('Mobile Team'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Mobile(
                            title: 'Mobile Team',
                          )),
                );
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor:
      //         _isMorning ? Colors.lightBlueAccent : Colors.deepPurpleAccent,
      //     child: Icon(
      //         _isMorning ? Icons.nightlight_round : Icons.wb_sunny_rounded),
      //     onPressed: () {
      //       setState(() {
      //         _isMorning = !_isMorning;
      //       });
      //     }),
    );
  }
}


// Stack() to stack widgets on top of each other

//const Positioned() to position widget inside stack (using height and width)

//Expanded() to give space to an empty widget such as Container()
///children:[
///Expanded(child: Container(color: Colors.yellow), flex: 2),
///Expanded(child: Container(color: Colors.red), flex: 1),
///Expanded(child: Container(color: Colors.blue), flex: 1),
///]

//Spacer() to add space between widgets = Expanded(child: SizedBox()),

