import 'package:bloc_weather/weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/weather/cubit/weather_state.dart';
import 'package:bloc_weather/weather/models/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route(WeatherCubit weatherCubit) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
              value: weatherCubit,
              child: const SettingsPage(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          BlocBuilder<WeatherCubit, WeatherState>(
              buildWhen: (previous, current) =>
                  previous.temperatureUnits != current.temperatureUnits,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: ListTile(
                        title: const Text('Temperature Units'),
                        isThreeLine: true,
                        subtitle: const Text(
                            'Use metric measurements for temperature units'),
                        trailing: Switch(
                            value: state.temperatureUnits.isCelsius,
                            onChanged: (_) =>
                                context.read<WeatherCubit>().toggleUnits()),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          state.temperatureUnits.isCelsius ? "C" : "F",
                          style: Theme.of(context).textTheme.titleLarge,
                        ))
                  ],
                );
              })
        ],
      ),
    );
  }
}
