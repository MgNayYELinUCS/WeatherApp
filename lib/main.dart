import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/search/search_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/ui/weather_home.dart';
import 'package:weather_app/utils/simple_bloc_deligate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const _title = "Weather App";
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context)=> ApiService.create(),
      child: Consumer<ApiService>(
        builder: (context,apiService,child){
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context)=> WeatherBloc(apiService: apiService),
              ),
              BlocProvider(
                create: (context)=> SearchBloc(api: apiService),
              )
            ],
            child: MaterialApp(
              title: _title,
              theme: ThemeData(
                primaryColor: Colors.red
              ),
              home: WeatherHome(),
            ),
          );
        },
      ) ,
    );
  }
}
