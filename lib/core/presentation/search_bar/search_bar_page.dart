import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/presentation/search_bar/search_bar_widget.dart';

class SearchBarPage extends StatelessWidget {
  final Function onUpdatedLocation;

  const SearchBarPage({super.key, required this.onUpdatedLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 60.0,
          horizontal: 20.0,
        ),
        child: SearchBarWidget(
          onTapItem: (result) {
            onUpdatedLocation(result);
            Timer(
              const Duration(microseconds: 500),
              () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
