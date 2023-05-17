import 'package:bloc_weather/theme/cubit/theme_cubit.dart';
import 'package:bloc_weather/weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/weather/view/widgets/search_page.dart';
import 'package:bloc_weather/weather/view/widgets/settings_page.dart';
import 'package:bloc_weather/weather/view/widgets/weather_empty.dart';
import 'package:bloc_weather/weather/view/widgets/weather_error.dart';
import 'package:bloc_weather/weather/view/widgets/weather_loading.dart';
import 'package:bloc_weather/weather/view/widgets/weather_populated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';

import '../cubit/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather bloc'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                    SettingsPage.route(context.read<WeatherCubit>()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<ThemeCubit>().updateTheme(state.weather);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return WeatherPopulated(
                      weather: state.weather,
                      units: state.temperatureUnits,
                      onRefresh: () {
                        return context.read<WeatherCubit>().refreshWeather('');
                      });
                case WeatherStatus.failure:
                  return const WeatherError();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.search,
          semanticLabel: 'Search',
        ),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city.toString().trim());
        },
      ),
    );
  }
}
