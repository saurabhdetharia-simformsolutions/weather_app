import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/presentation/detail_page/detail_bloc/detail_bloc.dart';
import 'package:weather_app/helper.dart';
import 'package:weather_app/image_const.dart';

import '../../../const.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.location,
    required this.temp,
    required this.name,
  }) : super(key: key);

  final Position? location;
  final String? temp;
  final String? name;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (mounted) {
      // Fetch the weather details for the current location
      context.read<DetailBloc>().add(GetDetailForecastEvent(
            location: connectivityResult != ConnectivityResult.none
                ? widget.location
                : null,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.black,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              if (state is DetailSuccess) {
                var dailyForecastResponse = state.dailyForecastResponse;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(CupertinoIcons.chevron_back),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.name ??
                                  (dailyForecastResponse.city?.name ?? '')
                                      .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.temp ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          var dailyForecast =
                              dailyForecastResponse.list![index];

                          final DateFormat formatter = DateFormat('EEEE');
                          final String day = formatter.format(
                              DateTime.now().add(Duration(days: index + 1)));

                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black38,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                SizedBox.square(
                                  dimension: 30,
                                  child: CircleAvatar(
                                    radius: 45,
                                    child: ClipOval(
                                      child: Image.network(
                                        getSmallIconUrl(dailyForecast
                                                .weather?.first.icon
                                                ?.toString() ??
                                            ''),
                                        fit: BoxFit.cover,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    day,
                                    style: style,
                                  ),
                                ),
                                Text(
                                  isCelsius
                                      ? '${toCelsius(dailyForecast.temp?.min ?? 0).toStringAsFixed(0)}°/${toCelsius(dailyForecast.temp?.max ?? 0).toStringAsFixed(0)}°'
                                      : '${toFahrenheit(dailyForecast.temp?.min ?? 0).toStringAsFixed(0)}°/${toFahrenheit(dailyForecast.temp?.max ?? 0).toStringAsFixed(0)}°',
                                  style: style,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    dailyForecast.weather?.first.main ?? '',
                                    style: style,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          );
                        },
                        itemCount: dailyForecastResponse.list?.length ?? 0,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: shimmerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 80,
                              height: 24,
                              decoration: BoxDecoration(
                                color: shimmerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 35,
                              height: 24,
                              decoration: BoxDecoration(
                                color: shimmerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: shimmerColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                          );
                        },
                        itemCount: 7,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
