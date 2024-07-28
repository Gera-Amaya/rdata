import 'dart:async';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_database/firebase_database.dart';
import 'gtemp.dart';
import 'ghume.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  double humidity = 0, temperature = 0;
  bool isLoading = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      getData();
    });
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      DataSnapshot tempSnapshot = await ref.child("Living Room/temperature/value").get();
      DataSnapshot humiSnapshot = await ref.child("Living Room/humidity/value").get();

      if (tempSnapshot.exists && humiSnapshot.exists) {
        setState(() {
          temperature = double.tryParse(tempSnapshot.value.toString()) ?? -1;
          humidity = double.tryParse(humiSnapshot.value.toString()) ?? -1;
        });
      } else {
        _handleDataError();
      }
    } catch (e) {
      print("Error al obtener datos: $e");
      _handleDataError();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleDataError() {
    setState(() {
      temperature = -1;
      humidity = -1;
    });
  }

  Color _getTemperatureColor() {
    if (temperature < 0) return Colors.blue;
    if (temperature <= 30) return Colors.green;
    return Colors.red;
  }

  String _getTemperatureMessage() {
    if (temperature < 0) return 'Hace frío';
    if (temperature <= 30) return 'Temperatura agradable';
    return 'Temperatura muy alta';
  }

  Color _getHumidityColor() {
    if (humidity < 0) return Colors.brown;
    if (humidity < 50) return Colors.yellow;
    return Colors.purple;
  }

  String _getHumidityMessage() {
    if (humidity < 0) return 'Tiempo seco';
    if (humidity < 50) return 'Humedad media';
    return 'Humedad alta';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Sensores'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: getData,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GTemp(temperature: temperature),
            SizedBox(height: 20),
            GHume(humidity: humidity),
            SizedBox(height: 20),
            Text(
              _getTemperatureMessage(),
              style: TextStyle(
                fontSize: 20,
                color: _getTemperatureColor(),
              ),
            ),
            SizedBox(height: 10),
            Text(
              _getHumidityMessage(),
              style: TextStyle(
                fontSize: 20,
                color: _getHumidityColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
