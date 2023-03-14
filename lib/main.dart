import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String batareya = 'Batateya';

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
            Text(
              batareya,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: RawMaterialButton(
        fillColor: Colors.deepOrange,
        splashColor: Colors.orange,
        shape: const StadiumBorder(),
        onPressed: _getBatteryInfo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.explore,
                color: Colors.amber,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text('PURCHASE',
              style: TextStyle(color: Colors.white ),),
            ],
          ),
        ),
      ),
    );
  }

  static const batteryChannel = MethodChannel('battery');

  Future<void> _getBatteryInfo() async {
    String batteryPercent;
    final arguments = {'name': 'Sarah Abs'};
    try {
      var result =
          await batteryChannel.invokeMethod('getBatteryLevel', arguments);
      batteryPercent = 'Batareya: $result%';
    } on PlatformException {
      batteryPercent = 'Batareya haqida malumt olishda xatolik berdi';
    }

    setState(() {
      batareya = batteryPercent;
    });
  }
}
