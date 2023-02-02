import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => MyHomePage(title: "Polygon"),
      },
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
  int _counter = 0;
  String _dataFromFlutter = "Android can ping you";
  static const platform = const MethodChannel('Polygon/test');

  Future<void> _getDataFromAndroid() async {
    // print("calling for data");
    String data;
    try {
      final String result = await platform.invokeMethod('test', {
        "data": "Welcome to Polygon. I'm coming from Flutter "
      }); //sending data from flutter here
      data = result;
    } on PlatformException catch (e) {
      data = "Android is not responding please check the code";
    }

    setState(() {
      _dataFromFlutter = data;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getDataFromAndroid();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_dataFromFlutter),
            ElevatedButton(
              onPressed: _getDataFromAndroid,
              child: Text("Ask android"),
            ),
          ],
        ),
      ),
    );
  }
}
