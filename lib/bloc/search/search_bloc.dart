import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/network/model/city_model.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final ApiService api;


  SearchBloc({@required this.api}): assert(api!=null);

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is FetchCityEvent){
      yield CityLoadingState();
      try{
        final response = await api.getCityes(event.cityName);
        yield CityLoadedState(cityModels: response);

      }on SocketException catch (e){
        yield CityErrorState(e.toString());
      }on Exception catch (e){
        yield CityErrorState(e.toString());
      }
    }
  }

  @override
  SearchState get initialState => SearchEmptyState();
}
