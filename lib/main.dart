import 'package:flutter/material.dart';
import 'package:weather_flutter_demo_app/models.dart';
import 'package:weather_flutter_demo_app/weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _cityTextController = TextEditingController();
  final _weatherService = WeatherService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _response != null ?
              Column(
                children: [
                  Image.network(_response.iconUrl),
                  Text(
                    '${_response.tempInfo.temperature.round()}°',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(_response.weatherInfo.description)
                ],
              ) : Image.network('https://media4.giphy.com/media/KnaVnAjfyoscdaH8SG/giphy.gif?cid=ecf05e47399xlsc0sblmdu6vbt0h7bymrp5ybz7p460evmtw&rid=giphy.gif&ct=g'),
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextField(
                controller: _cityTextController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  hintText: 'City',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: _search,
                child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  void _search() async {
    final response = await _weatherService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }

}
