import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/presentation/settings/bloc/frequency/frequency_bloc.dart';
import 'package:weather_app/core/presentation/settings/bloc/temperature/temperature_bloc.dart';
import 'package:weather_app/core/presentation/weather/weather_bloc/weather_bloc.dart';

import 'core/presentation/splash/splash_page.dart';
import 'injection.dart' as di;
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<WeatherBloc>()),
        BlocProvider(create: (_) => sl<TemperatureBloc>()),
        BlocProvider(create: (_) => sl<FrequencyBloc>()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            background: Colors.lightBlue.shade50,
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
