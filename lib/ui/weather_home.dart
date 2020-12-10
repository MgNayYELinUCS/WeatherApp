import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/network/model/weathers_model.dart';
import 'package:weather_app/ui/login_page.dart';
import 'package:weather_app/ui/search_area.dart';
import 'package:weather_app/utils/helper.dart';

class WeatherHome extends StatefulWidget {
  final int cityCode;

  WeatherHome({this.cityCode = 1015662});

  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final newdateFormat = DateFormat("dd/MM/yy H:m:s");
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    BlocProvider.of<WeatherBloc>(context)..add(FetchWeather(cityCode: widget.cityCode));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading:Builder(
          builder: (BuildContext context){
            return IconButton(
                icon: Icon(Icons.home),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>LoginPage())
                  );
                }
            );
          },
        ),
        title:Text("Weather App"),
        actions: [
          IconButton(icon: Icon(Icons.search),
              tooltip: "Search City",
              onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>SearchArea()
                      )
                  );
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child:BlocBuilder<WeatherBloc,WeatherState>(
          builder: (context,state){
            if(state is LoadingWeatherState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is LoadedWeatherState){
              return _weatherList(state.weatherModel);
            }
            if(state is ErrorWeatherState){
              return Container(
                child: Center(
                  child: Text(
                    "No Internet Connection"
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                "No Data"
              ),
            ) ;
          },
        )
      ),
    );
  }
  ListView _weatherList(WeatherModel weatherModel){
    return ListView(
      children:<Widget> [
        Column(
          children: <Widget>[
            Text(
              "${weatherModel.title}",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  textStyle: Theme.of(context).textTheme.headline2
              ),
            ),
            Text(
                "Update: "+ newdateFormat.format(DateTime.parse(weatherModel.weatherStates[0].created)).toString()
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                width: 150.0,
                image: AssetImage("assets/images/${MyHelper.mapStringToImage(weatherModel.weatherStates[0].weatherStateAbbr)}.png"),
              ),
            ),
            Text(
              "${weatherModel.weatherStates[0].weatherStateName}",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                  textStyle: Theme.of(context).textTheme.headline5
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget> [
                Text(
                  "${weatherModel.weatherStates[0].theTemp.toInt()}'C",
                  style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.headline3,
                      color: Colors.red
                  ),
                ),
                Column(
                  children: [
                    Text("min: ${weatherModel.weatherStates[0].minTemp.toInt()}'C"),
                    Text("max: ${weatherModel.weatherStates[0].maxTemp.toInt()}'C")
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

