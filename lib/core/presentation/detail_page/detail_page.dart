import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/presentation/detail_page/detail_bloc/detail_bloc.dart';
import 'package:weather_app/image_const.dart';
import 'package:weather_app/temperature_conversion_helper.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Position location;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (mounted) {
      // Fetch the weather details for the current location
      context.read<DetailBloc>().add(GetDetailForecastEvent(
            location: widget.location,
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
                              (dailyForecastResponse.city?.name ?? '')
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${toCelsius(dailyForecastResponse.list?.first.temp?.day ?? 0).toStringAsPrecision(2)}°',
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
                          final String day = formatter.format(DateTime.now().add(Duration(days: index+1)));

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
                                const Spacer(),
                                Text(
                                  day,
                                  style: style,
                                ),
                                const Spacer(),
                                Text(
                                  '${toCelsius(dailyForecast.temp?.day ?? 0).toStringAsPrecision(2)}°',
                                  style: style,
                                ),
                                const Spacer(),
                                Text(
                                  dailyForecast.weather?.first.main ?? '',
                                  style: style,
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
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
