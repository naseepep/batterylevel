import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GetBtteryLvel(),
    );
  }
}

class GetBtteryLvel extends StatefulWidget {
  const GetBtteryLvel({super.key});

  @override
  State<GetBtteryLvel> createState() => _GetBtteryLvelState();
}

class _GetBtteryLvelState extends State<GetBtteryLvel> {
  static const platform = MethodChannel("samples.flutter.dev/battery");
  String _batterylevel = 'unknown battery level';
  Future<void> getBatteryLevel() async {
    String batterylvl;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batterylvl = 'batterylevel at $result%';
    } on PlatformException catch (e) {
      batterylvl = 'failed to get battery level ${e.code}';
    }
    setState(() {
      _batterylevel = batterylvl;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        //appBar: AppBar(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.yellow),
                  onPressed: getBatteryLevel,
                  child: Text(
                    'Get Battery Level',
                    style: TextStyle(fontSize: 30),
                  )),
                  SizedBox(height: 15,),
              Text(_batterylevel),
            ],
          ),
        ),
        );
  }
}
