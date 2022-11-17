import 'package:flutter/material.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Weather/models/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Weather extends StatefulWidget {
  Weather({Key key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherData weather;
  SimpleLocationResult selectedLocation;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    weather = arguments['weatherData'];
    selectedLocation = arguments['selectedLocation'];
     print(DateFormat("EEE")
         .format(DateTime.now()),);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacementNamed(context, '/loading',
            arguments: selectedLocation);
        return null;
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.indigo,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weather.name,
                                    style: GoogleFonts.lato(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("EEE, d LLL")
                                        .format(DateTime.now()),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                // 8.251978408455566, 77.34499943329884
                                onPressed: () {
                                  double latitude = selectedLocation != null
                                      ? selectedLocation.latitude
                                      : 8.251978408455566;
                                  double longitude = selectedLocation != null
                                      ? selectedLocation.longitude
                                      : 77.34499943329884;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SimpleLocationPicker(
                                                initialLatitude: latitude,
                                                initialLongitude: longitude,
                                                appBarTitle: "Select Location",
                                                zoomLevel: 8,
                                                appBarColor: Colors.indigo,
                                                markerColor: Colors.indigo,
                                              ))).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedLocation = value;
                                        Navigator.pushReplacementNamed(
                                            context, "/loading",
                                            arguments: selectedLocation);
                                      });
                                    }
                                  });
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Column(children: [
                          Transform.scale(
                              scale: 1.6,
                              child: SvgPicture.asset(
                                  "assets/svgs/${weather.icon}.svg")),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weather.temperature.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 65,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "°C",
                                style: GoogleFonts.lato(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Text(
                            weather.condition,
                            style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Feels like ${weather.feelsLike}°C",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                      onTap: (){

                          deleteDialog(context,"Visibility is a measure of the horizontal opacity of the atmosphere at the point of observation and is expressed in terms of the horizontal distance at which a person should be able to see and identify in the daytime.");

                      },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.indigo
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    FontAwesome5Solid.eye,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("Visibility",
                                    style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  "${weather.visibility} km",
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          deleteDialog(context,"Humidity is the amount of water vapor in the air. If there is a lot of water vapor in the air, the humidity will be high. The higher the humidity, the wetter it feels outside. On the weather reports, humidity is usually explained as relative humidity.");

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.indigo,
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Ionicons.ios_water,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("Humidity",
                                    style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  "${weather.humidity}%",
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          deleteDialog(context,"Wind speed describes how fast the air is moving past a certain point. This may be an averaged over a given unit of time, such as miles per hour, or an instantaneous speed, which is reported as a peak wind speed, wind gust or squall.");

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.indigo,
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    FontAwesome5Solid.wind,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("Wind Speed",
                                    style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  "${weather.windSpeed.floor()} km/hr",
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),

              Container(
                child: Column(
                  children: [
                    Container(
                        // height: 240,

                        width: MediaQuery.of(context).size.width * 0.90,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "\nThis week\n",
                            style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        )),
                    Container(
                        // margin: EdgeInsets.only(top: 10),
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: ListView.builder(
                          itemCount: weathertody.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Container(
                                color:Colors.indigo,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    weathertody[index]["days"]== DateFormat("EEE")
                                        .format(DateTime.now())?SvgPicture.asset("assets/svgs/${weather.icon}.svg"):  SvgPicture.asset(weathertody[index]["image"]),
                                    weathertody[index]["days"]== DateFormat("EEE")
                                        .format(DateTime.now())?Text(weathertody[index]["day"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),):Text(weathertody[index]["day"]),
                                    weathertody[index]["days"]== DateFormat("EEE")
                                        .format(DateTime.now())?Text("${weather.temperature.toString()}°C",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),):Text(weathertody[index]["degree"]),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List weathertody = [
    {"day": "Monday", "image": "assets/svgs/09n.svg", "degree": "25°C","days":"Mon"},
    {"day": "Tuesday", "image": "assets/svgs/09n.svg", "degree": "25°C","days":"Tue"},
    {"day": "wednesday", "image": "assets/svgs/09n.svg", "degree": "25°C","days":"Wed"},
    {"day": "Thursday", "image": "assets/svgs/09n.svg", "degree": "24°C","days":"Thu"},
    {"day": "Friday", "image": "assets/svgs/13d.svg", "degree": "24°C","days":"Fri"},
    {"day": "Saturday", "image": "assets/svgs/13d.svg", "degree": "24°C","days":"Sat"},
    {"day": "Sunday", "image": "assets/svgs/13d.svg", "degree": "24°C","days":"Sun"},
  ];

}
deleteDialog(BuildContext context,String txt){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ), //this right here
          child: Container(
            padding: EdgeInsets.all(20),
            // height: MediaQuery.of(context).size.height*0.40,
            // width: MediaQuery.of(context).size.width*0.70 ,
            child: Text(txt, style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              // color: Colors.white,
            )),
          ),
        );

      });
}
