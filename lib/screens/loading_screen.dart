import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempo_template/services/location.dart';
import 'package:tempo_template/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '3139fffd8993df60af114840d40d010a';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  void pushToLocationScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LocationScreen();
    }));
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/'
        'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    this.pushToLocationScreen();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude!;
    longitude = location.longitude!;

    getData();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitSpinningLines(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
