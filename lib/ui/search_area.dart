import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/search/search_bloc.dart';
import 'package:weather_app/network/model/city_model.dart';
import 'package:weather_app/ui/weather_home.dart';

class SearchArea extends StatefulWidget {
  @override
  _SearchAreaState createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  final TextEditingController _searhController = TextEditingController();
  @override
  void dispose() {
    _searhController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(
          "Search"
        ),
      ),
      body:Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:TextFormField(
                      controller: _searhController,
                      decoration: InputDecoration(
                          labelText: "Search City",
                          border: OutlineInputBorder()
                      ),
                    )
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.blue,
                    onPressed: (){
                      if(_searhController.text != ""){
                        print(_searhController.text);
                        searchBloc..add(FetchCityEvent(cityName: _searhController.text));
                      }
                    }
                )
              ],
            ),
            Expanded(
                child: BlocBuilder<SearchBloc,SearchState>(
                  builder: (context,state){

                    if(state is SearchEmptyState ){
                      return Center(
                        child: Text(
                          "Type Some thing to Search"
                        ),
                      );
                    }

                    if(state is CityLoadingState){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(state is CityLoadedState){
                      return ListView.builder(
                          itemCount: state.cityModels.length,
                          itemBuilder: (BuildContext context,int index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>WeatherHome(cityCode: state.cityModels[index].woeid)
                                    )
                                );
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "${state.cityModels[index].title}",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        textStyle: Theme.of(context).textTheme.headline6
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      );;
                    }
                    if(state is CityErrorState){
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return Center(
                      child: Text("No Data"),
                    );
                  },

                )
            )
          ],
        ),
      )
    );
  }
  ListView _listCity(List<CityModel> cityModels){
    return  ListView.builder(
        itemCount: cityModels.length,
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>WeatherHome(cityCode: cityModels[index].woeid)
                    )
                );
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "${cityModels[index].title}",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      textStyle: Theme.of(context).textTheme.headline6
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
