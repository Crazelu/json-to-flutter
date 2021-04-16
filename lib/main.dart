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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      loadJson();
    });
  }

  void loadJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/test_json.json");
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
              Text(
                "Nothing to see here on gad",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal),
              ),
              SizedBox(height: 30),
              if (_ui != null)
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => kButtonBackgroundColor)),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (context, primary, secondary) =>
                              JsonUIDialog(jsonUI: _ui!)));
                    },
                    child: Text('Open full screen dialog',
                        style:
                            TextStyle(fontSize: 15, color: kPrimaryColorLight)))
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
            if (jsonUI.isDismissWithBackbuttonEnabled) {
              dismiss(context);
            } else {
              print(jsonUI.dismissErrorMessage);
            }
            return Future.value(false);
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: jsonUI.widgets,
              ),
            ),
          ),
        ));
  }
}
