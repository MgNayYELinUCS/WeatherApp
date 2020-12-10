part of 'weather_bloc.dart';
abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class EmptyWeatherState extends WeatherState {}

class LoadingWeatherState extends WeatherState{}

class LoadedWeatherState extends WeatherState{
  final WeatherModel weatherModel;
  LoadedWeatherState({@required this.weatherModel}): assert(weatherModel!=null);

  @override
  List<Object> get props => [weatherModel];
}
class ErrorWeatherState extends WeatherState{
  final String message;
  ErrorWeatherState(this.message);
}
