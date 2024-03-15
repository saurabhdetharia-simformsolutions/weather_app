import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/domain/repositories/app_setting_repository.dart';
import 'package:weather_app/core/presentation/settings/settings_bloc/settings_bloc.dart';

import '../../../injection.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _temperatureSettings,
                const SizedBox(
                  height: 20,
                ),
                _frequencySettings,
              ],
            )),
      ),
    );
  }

  /// To show the temperature settings

  Widget get _temperatureSettings => BlocProvider(
        create: (context) => TemperatureBloc(
          appSettingRepository: sl<AppSettingRepository>(),
        )..add(GetTemperatureSettingsEvent()),
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Temprature unit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => context
                    .read<TemperatureBloc>()
                    .add(UpdateCelsiusEvent(isCelsiusSelected: true)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Celsius',
                      style: TextStyle(fontSize: 15),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: BlocBuilder<TemperatureBloc,
                          TemperatureSettingsState>(
                        builder: (context, state) {
                          return CupertinoSwitch(
                            value: state is TemperatureSettingsFetched
                                ? state.shouldShowCelsius
                                : state is CelsiusUpdated
                                    ? state.isSelected
                                    : state is FahrenheitUpdated
                                        ? !state.isSelected
                                        : false,
                            onChanged: (isSelected) {
                              context.read<TemperatureBloc>().add(
                                  UpdateCelsiusEvent(
                                      isCelsiusSelected: isSelected));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fahrenheit',
                    style: TextStyle(fontSize: 15),
                  ),
                  BlocBuilder<TemperatureBloc, TemperatureSettingsState>(
                    builder: (context, state) {
                      print(state);
                      return Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: state is TemperatureSettingsFetched
                              ? state.shouldShowFahrenheit
                              : state is CelsiusUpdated
                                  ? !state.isSelected
                                  : state is FahrenheitUpdated
                                      ? state.isSelected
                                      : false,
                          onChanged: (isSelected) => context
                              .read<TemperatureBloc>()
                              .add(UpdateFahrenheitEvent(
                                  isFahrenheitSelected: isSelected)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        }),
      );

  /// To show the frequency settings

  Widget get _frequencySettings => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frequency',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '10 minutes',
                style: TextStyle(fontSize: 15),
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (isSelected) {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '30 minutes',
                style: TextStyle(fontSize: 15),
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: false,
                  onChanged: (isSelected) {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '60 minutes',
                style: TextStyle(fontSize: 15),
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (isSelected) {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      );
}
