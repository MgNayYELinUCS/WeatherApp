import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/network/model/weathers_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final ApiService apiService;

  WeatherBloc({@required this.apiService}):assert (apiService != null);

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is FetchWeather){
      yield LoadingWeatherState();

      try{
        final response = await apiService.getWeather(event.cityCode);
        yield LoadedWeatherState(weatherModel: response);
      }on SocketException{
        yield ErrorWeatherState(e.toString());
      }on Exception{
        yield ErrorWeatherState(e.toString());
      }
    }
  }

  @override
  WeatherState get initialState => EmptyWeatherState();
}
