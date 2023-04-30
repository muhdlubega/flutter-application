import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (BuildContext context) {
        return WeatherCubit();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String userInput = 'Cyberjaya';
  late WeatherCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<WeatherCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await cubit.getCurrentWeatherData(userInput);
    });

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        bloc: cubit,
        builder: (context, state) {
          Widget widget = Container();
          if (state is WeatherStateLoading) {
            widget = const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherStateLoaded) {
            widget = Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    cubit.backgroundImageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    'Search a city name:',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            style: const TextStyle(color: Colors.white),
                            onSubmitted: (String value) {
                              setState(() {
                                userInput = value;
                                BlocProvider.of<WeatherCubit>(context)
                                    .getCurrentWeatherData(userInput);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    userInput = _textEditingController.text;
                                    BlocProvider.of<WeatherCubit>(context)
                                        .getCurrentWeatherData(userInput);
                                  });
                                },
                                icon: const Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    BlocProvider.of<WeatherCubit>(context)._location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    BlocProvider.of<WeatherCubit>(context)._weatherCondition,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${BlocProvider.of<WeatherCubit>(context)._temperature}° ${BlocProvider.of<WeatherCubit>(context)._temperatureUnit}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<WeatherCubit>(context)
                          .toggleTemperatureUnit();
                    },
                    child: const Text('Toggle Temperature Unit'),
                  ),
                  const Spacer(),
                ],
              ),
            );
          } else if (state is WeatherStateError) {
            widget = const Center(
              child: Text(
                'Error occured! try again later.',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }
          return widget;
        },
      ),
    );
  }
}

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherStateInitial());

  String _weatherCondition = '';
  String _temperature = '';
  String _location = '';
  String _backgroundImageUrl = '';
  String _temperatureUnit = 'Celsius';

  String get backgroundImageUrl => _backgroundImageUrl;

  Future<void> getCurrentWeatherData(String city) async {
    print('getCurrentWeatherData');
    emit(WeatherStateLoading());

    final response = await http.get(Uri.parse(
        // 'https://api.openweathermap.org/data/2.5/weather?q=New+York&appid=4e7159ca25e61b17cd1f8b4f2db95cdd'));
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=4e7159ca25e61b17cd1f8b4f2db95cdd'));
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weather = data['weather'][0];
      final main = data['main'];
      final temp = main['temp'];
      final tempInCelsius = temp - 273.15;

      _weatherCondition = weather['main'];
      _temperature = tempInCelsius.toStringAsFixed(0);
      _location = data['name'];
      _backgroundImageUrl = getBackgroundImageUrl(_weatherCondition);

      emit(WeatherStateLoaded(_weatherCondition));
    } else {
      emit(WeatherStateError());
      // throw Exception('Failed to load weather data');
    }
  }

  String getBackgroundImageUrl(String weatherCondition) {
    switch (weatherCondition) {
      case 'Clear':
        return 'https://images.pexels.com/photos/998660/pexels-photo-998660.jpeg';
      case 'Clouds':
        return 'https://images.pexels.com/photos/2114014/pexels-photo-2114014.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';
      case 'Rain':
      case 'Drizzle':
        return 'https://images.pexels.com/photos/7002973/pexels-photo-7002973.jpeg';
      case 'Thunderstorm':
        return 'https://images.pexels.com/photos/680940/pexels-photo-680940.jpeg';
      case 'Snow':
        return 'https://images.pexels.com/photos/624015/pexels-photo-624015.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
        return 'https://images.pexels.com/photos/1743392/pexels-photo-1743392.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';
      default:
        return 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJhY2tncm91bmR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80';
    }
  }

  void toggleTemperatureUnit() {
    if (_temperatureUnit == 'Celsius') {
      double temperatureInFahrenheit = double.parse(_temperature) * 9 / 5 + 32;
      _temperature = temperatureInFahrenheit.toStringAsFixed(1);
      _temperatureUnit = 'Fahrenheit';
    } else {
      double temperatureInCelsius = (double.parse(_temperature) - 32) * 5 / 9;
      _temperature = temperatureInCelsius.toStringAsFixed(1);
      _temperatureUnit = 'Celsius';
    }
    emit(WeatherStateLoaded(_location));
  }

  void fetchWeather(String location) async {
    if (location.isEmpty) {
      emit(WeatherStateLoading());
    } else {
      emit(WeatherStateLoading());
    }
    await Future.delayed(const Duration(seconds: 1));

    emit(WeatherStateLoaded(_location));
  }
}

abstract class WeatherState {}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateError extends WeatherState {}

class WeatherStateLoaded extends WeatherState {
  WeatherStateLoaded(this.weatherCondition);

  final String weatherCondition;
}
