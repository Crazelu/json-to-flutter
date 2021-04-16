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
  }

  void loadJson(String asset) async {
    String data = await DefaultAssetBundle.of(context).loadString(asset);
    _json = json.decode(data);
    _ui = JsonUI.fromJson(_json);
    setState(() {});
    if (_ui != null) {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, primary, secondary) =>
              JsonUIDialog(jsonUI: _ui!)));
    }
  }

  final kVerticalSpace = SizedBox(height: 10);

  TextButton getButton(String text, String asset) => TextButton(
      style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.resolveWith((states) => Size(200, 80)),
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => kButtonBackgroundColor)),
      onPressed: () {
        loadJson("assets/$asset.json");
      },
      child: Text(text,
          style: TextStyle(fontSize: 18, color: kPrimaryColorLight)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColorLight,
        appBar: AppBar(
          backgroundColor: kButtonSplashColor,
          elevation: 0,
          centerTitle: true,
          title: Text("JSON to Flutter UI Demo",
              style: TextStyle(color: kPrimaryColorLight)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getButton('Open Foodr dialog', 'test_json'),
              kVerticalSpace,
              getButton('Open Netflix dialog', 'netflix'),
              kVerticalSpace,
              getButton('Open Abeg dialog', 'abeg'),
            ],
          ),
        ));
  }
}

class JsonUIDialog extends StatelessWidget {
  final JsonUI jsonUI;
  const JsonUIDialog({Key? key, required this.jsonUI}) : super(key: key);

  void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: jsonUI.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: jsonUI.backgroundColor,
          elevation: 0,
          actions: [
            if (jsonUI.shouldShowDismiss)
              FloatingActionButton(
                  mini: true,
                  backgroundColor: jsonUI.dismissButtonColor,
                  child: Icon(
                    Icons.close,
                    color: jsonUI.dismissIconColor,
                  ),
                  onPressed: () {
                    dismiss(context);
                  }),
          ],
        ),
        body: WillPopScope(
          onWillPop: () {
            dismiss(context);

            return Future.value(false);
          },
          child: Container(
              height: size.height, width: size.width, child: jsonUI.widget),
        ));
  }
}
