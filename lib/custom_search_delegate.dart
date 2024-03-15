import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/presentation/weather/weather_bloc/weather_bloc.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final WeatherBloc weatherBloc;

  CustomSearchDelegate(
      {required this.weatherBloc}); // These methods are mandatory you cannot skip them.

  @override
  List<Widget> buildActions(BuildContext context) {
    // Build the clear button.
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Build the leading icon.
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    weatherBloc.add(SearchLocationEvent(location: query));

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is SearchLocationState) {
          return ListView.builder(
            itemCount: state.searchLocationRes.results.length,
            itemBuilder: (context, index) {
              var result = state.searchLocationRes.results[index];
              return ListTile(
                title: Text(result.name),
                onTap: () {
                  // Handle the selected search result.
                  close(context, result.latitude.toString());
                },
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    weatherBloc.add(SearchLocationEvent(location: query));

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is SearchLocationState) {
          return ListView.builder(
            itemCount: state.searchLocationRes.results.length,
            itemBuilder: (context, index) {
              var result = state.searchLocationRes.results[index];
              return ListTile(
                title: Text(result.name),
                onTap: () {
                  // Handle the selected search result.
                  close(context, result.latitude.toString());
                },
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
