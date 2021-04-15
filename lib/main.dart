import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_to_flutter/models/ui/ui.dart';

import 'constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON to Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _json;
  JsonUI? _ui;
  @override
  void initState() {
    super.initState();
    loadJson();
  }

  void loadJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/test_json.json");
    _json = json.decode(data);
    _ui = JsonUI.fromJson(_json);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _ui != null ? _ui!.backgroundColor : Colors.white,
        appBar: AppBar(
          backgroundColor: kButtonSplashColor,
          elevation: 0,
          title: Text("JSON to Flutter UI",
              style: TextStyle(color: kPrimaryColorLight)),
        ),
        body: Center(
          child: _ui == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _ui!.widgets,
                ),
        ));
  }
}
