import 'package:flutter/material.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class SoonPage extends StatefulWidget {
  const SoonPage({Key? key}) : super(key: key);

  @override
  _SoonPageState createState() => _SoonPageState();
}

class _SoonPageState extends State<SoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('oi'),
      // ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          // Manage your route names here
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => OtherPage();
              break;
            case '/page1':
              builder = (BuildContext context) => Other2Page();
              break;
            case '/page2':
              builder = (BuildContext context) => OtherPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          // You can also return a PageRouteBuilder and
          // define custom transitions between pages
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }
}

class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('oi'),
      ),
      body: Container(
        child: Container(
          color: Colors.red,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.red[300],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  _navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (BuildContext context) => Other2Page(),
                  ));
                },
                child: const Text('1'),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Other2Page extends StatefulWidget {
  const Other2Page({Key? key}) : super(key: key);

  @override
  State<Other2Page> createState() => _Other2PageState();
}

class _Other2PageState extends State<Other2Page> {
  @override
  Widget build(BuildContext context) {
    int teste = 0;
    bool testetrue = true;
    return Scaffold(
        appBar: AppBar(
          title: Text('2'),
        ),
        body: Container(
          color: Colors.red,
          child: Text("oi"),
        ));
  }
}
