import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/core/presentation/settings/bloc/temperature/temperature_bloc.dart';

import '../../../image_const.dart';
import '../../../injection.dart';
import '../weather/weather_bloc/weather_bloc.dart';
import '../weather/weather_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          splashIcon,
        ),
      ),
    );
  }

  /// To navigate to next page
  void _navigateToNextPage() {
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const WeatherPage();
          }),
        );
      },
    );
  }
}
