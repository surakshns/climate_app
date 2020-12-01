import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

var apikey = 'e8ec6604d41030b781ce36b95e29b9da';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  double latitude;
  double longitude;

  void initState() {
    super.initState();
    getloctionData();
  }
  void getloctionData() async {
     Location loc = Location();
     await loc.getCurrentLocation();
     print(loc.latitude);
      latitude=loc.latitude;
      longitude=loc.longitude;

      NetworkHelper networkHelper= NetworkHelper('http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey');

     var weatherData = await networkHelper.getData();

     Navigator.push(context, MaterialPageRoute(builder: (context){
       return LocationScreen(network: weatherData,);
     }));



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
