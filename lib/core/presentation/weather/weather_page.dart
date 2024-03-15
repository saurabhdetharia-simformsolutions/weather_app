import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart';
import 'package:weather_app/core/presentation/detail_page/detail_bloc/detail_bloc.dart';
import 'package:weather_app/core/presentation/settings/settings_page.dart';
import 'package:weather_app/image_const.dart';

import '../../../const.dart';
import '../../../core/presentation/weather/weather_bloc/weather_bloc.dart';
import '../../../helper.dart';
import '../../../injection.dart';
import '../../app_strings.dart';
import '../../data/models/search_location/search_location_res.dart';
import '../detail_page/detail_page.dart';
import '../search_bar/search_bar_page.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Position? location;
  String? name;
  late ConnectivityResult connectivityResult;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      // Get the lat-long for the current location.

      if (mounted) {
        // Fetch the weather details for the current location
        context.read<WeatherBloc>().add(GetWeatherDetailsEvent(
              name: null,
              latitude: null,
              longitude:null,
            ));
      }
      location = await _getCurrentLocation();
      if(mounted){
        context.read<WeatherBloc>().add(GetWeatherDetailsEvent(
          name: null,
          latitude: location!.latitude.toString(),
          longitude: location!.longitude.toString(),
        ));
      }
    } else {
      if (mounted) {
        context.read<WeatherBloc>().add(GetWeatherDetailsEvent(
              name: null,
              latitude: null,
              longitude: null,
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header,
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherSuccess) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SettingsPage();
                                },
                              ),
                            ).then((value) {
                              context.read<WeatherBloc>().add(
                                  WeatherTempConvertEvent(
                                      weatherDetailsResponse:
                                          weatherDetailsResponse!));
                            });
                          },
                          child: const Icon(
                            CupertinoIcons.gear,
                            size: 30,
                          ),
                        );
                      } else {
                        return Icon(
                          CupertinoIcons.gear,
                          size: 30,
                          color: shimmerColor,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            _weatherIcon,
            const SizedBox(
              height: 5,
            ),
            _weatherInfo,
            const Spacer(),
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -5),
                      blurRadius: 20),
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: GestureDetector(
                onTap: () async {
                  connectivityResult =
                      await (Connectivity().checkConnectivity());

                  if (connectivityResult != ConnectivityResult.none &&
                      mounted) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SearchBarPage(
                        onUpdatedLocation: (Result result) {
                          location = Position(
                              longitude: result.longitude,
                              latitude: result.latitude,
                              timestamp: DateTime.now(),
                              accuracy: 0,
                              altitude: 0,
                              altitudeAccuracy: 0,
                              heading: 0,
                              headingAccuracy: 0,
                              speed: 0,
                              speedAccuracy: 0);
                          name = result.name;
                          context.read<WeatherBloc>().add(
                              GetWeatherDetailsEvent(
                                  name: result.name,
                                  latitude: result.latitude.toString(),
                                  longitude: result.longitude.toString()));
                        },
                      );
                    }));
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(youAreOffline),
                      ));
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.lightBlue.shade50,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        searchYourLocation,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header
  Widget get _header => BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.weatherDetailsResponse.name ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                _day,
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 50,
                  height: 20,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            );
          }
        },
      );

  /// Day info
  Widget get _day {
    final DateFormat formatter = DateFormat('EEEE');
    final String formatted = formatter.format(DateTime.now());
    return Text(
      formatted,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Icon for the current weather
  Widget get _weatherIcon => BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherSuccess) {
            return Center(
              child: SvgPicture.asset(
                'assets/images/${(state.weatherDetailsResponse.weather?.first.icon ?? '')}.svg',
                height: 180,
                width: 180,
              ),
            );
          } else {
            return Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: shimmerColor,
                ),
              ),
            );
          }
        },
      );

  /// Detail view button
  Widget get _detailViewButton => GestureDetector(
        onTap: () => _navigateToNextPage(location),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.black,
              )),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          child: const Text(
            seeNextSevenDays,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  CurrentWeatherRes? weatherDetailsResponse;

  /// Weather information
  Widget get _weatherInfo => BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherSuccess) {
            weatherDetailsResponse = state.weatherDetailsResponse;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      isCelsius
                          ? '${toCelsius(weatherDetailsResponse!.main?.temp ?? 0).toStringAsPrecision(2)}°'
                          : '${toFahrenheit(weatherDetailsResponse!.main?.temp ?? 0).toStringAsPrecision(2)}°',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        height: 0.9,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    weatherDetailsResponse!.weather?.first.main ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        windIcon,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${weatherDetailsResponse!.wind?.speed ?? 0}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(
                        tempIcon,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        isCelsius
                            ? '${toCelsius(weatherDetailsResponse!.main?.feelsLike ?? 0).toStringAsPrecision(2)}°'
                            : '${toFahrenheit(weatherDetailsResponse!.main?.feelsLike ?? 0).toStringAsPrecision(2)}°',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(
                        cloudIcon,
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${weatherDetailsResponse!.clouds?.all ?? 0}%',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(
                        humidityIcon,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${weatherDetailsResponse!.main?.humidity ?? 0}%',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _detailViewButton,
                ],
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 70,
                  height: 15,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 10,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 10,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 10,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 10,
                      decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 130,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: shimmerColor,
                  ),
                ),
              ],
            );
          }
        },
      );

  /// To navigate to next page
  void _navigateToNextPage(
    Position? location,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (context) => sl<DetailBloc>(),
          child: DetailPage(
            name: name,
            location: location,
            temp: isCelsius
                ? '${toCelsius(weatherDetailsResponse!.main?.temp ?? 0).toStringAsPrecision(2)}°'
                : '${toFahrenheit(weatherDetailsResponse!.main?.temp ?? 0).toStringAsPrecision(2)}°',
          ),
        );
      }),
    );
  }
}

/// To check and get the location...
Future<Position> _getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return defaultPosition;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return defaultPosition;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
