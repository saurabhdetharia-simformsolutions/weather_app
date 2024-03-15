import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/domain/repositories/app_setting_repository.dart';

import '../../../injection.dart';
import '../../app_strings.dart';
import 'bloc/frequency/frequency_bloc.dart';
import 'bloc/temperature/temperature_bloc.dart';

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
        title: const Text(settings),
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
        )..add(
            GetTemperatureSettingsEvent(),
          ),
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                temperatureUnit,
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
                      celsius,
                      style: TextStyle(fontSize: 15),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: BlocBuilder<TemperatureBloc, TemperatureState>(
                        builder: (context, state) {
                          return CupertinoSwitch(
                            activeColor: Colors.lightBlue.shade200,
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
                    fahrenheit,
                    style: TextStyle(fontSize: 15),
                  ),
                  BlocBuilder<TemperatureBloc, TemperatureState>(
                    builder: (context, state) {
                      return Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: Colors.lightBlue.shade200,
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

  Widget get _frequencySettings => BlocProvider(
        create: (context) => FrequencyBloc(
          appSettingRepository: sl<AppSettingRepository>(),
        )..add(GetFrequencySettingsEvent()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              frequency,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              updateWeatherDetails,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<FrequencyBloc, FrequencyState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      tenMin,
                      style: TextStyle(fontSize: 15),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        activeColor: Colors.lightBlue.shade200,
                        value: state is FrequencySettingsFetched
                            ? state.isTenMinsFreqEnabled
                            : state is FrequencyTenMinsUpdated
                                ? state.isSelected
                                : false,
                        onChanged: (isSelected) => context
                            .read<FrequencyBloc>()
                            .add(UpdateTenMinsFreqEvent(
                                isTenMinFreqEnabled: isSelected)),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<FrequencyBloc, FrequencyState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      thirtyMin,
                      style: TextStyle(fontSize: 15),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        activeColor: Colors.lightBlue.shade200,
                        value: state is FrequencySettingsFetched
                            ? state.isThirtyMinsFreqEnabled
                            : state is FrequencyThirtyMinsUpdated
                                ? state.isSelected
                                : false,
                        onChanged: (isSelected) => context
                            .read<FrequencyBloc>()
                            .add(UpdateThirtyMinsFreqEvent(
                                isThirtyMinFreqEnabled: isSelected)),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<FrequencyBloc, FrequencyState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      sixtyMin,
                      style: TextStyle(fontSize: 15),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        activeColor: Colors.lightBlue.shade200,
                        value: state is FrequencySettingsFetched
                            ? state.isSixtyMinsFreqEnabled
                            : state is FrequencySixtyMinsUpdated
                                ? state.isSelected
                                : false,
                        onChanged: (isSelected) => context
                            .read<FrequencyBloc>()
                            .add(UpdateSixtyMinsFreqEvent(
                                isSixtyMinFreqEnabled: isSelected)),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      );
}
