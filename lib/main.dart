import 'package:aplikasi_cuaca/data_service.dart';
import 'package:aplikasi_cuaca/weather.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  TextEditingController controller = TextEditingController();
  DataService dataService = DataService();
  Weather weather = Weather();
  bool isFetch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API cuaca'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isFetch
                ? Column(
                    children: [
                      Image.network(
                          'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                      Text(
                        '${weather.temp}°',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(weather.description,
                          style: Theme.of(context).textTheme.headline4)
                    ],
                  )
                : SizedBox(),
            Container(
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 50),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'city'),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  isFetch = true;
                  weather = await dataService.fetchData(controller.text);
                  setState(() {});
                },
                child: Text('search'))
          ],
        ),
      ),
    );
  }
}
