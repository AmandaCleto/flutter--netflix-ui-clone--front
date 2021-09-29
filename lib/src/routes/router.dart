import 'package:flutter/material.dart';
import 'package:ui_clone_netflix/src/pages/home/detailedItem/detailedItem.dart';
import 'package:ui_clone_netflix/src/pages/index.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => IndexPage());
      case '/detailedPage':
        return MaterialPageRoute(
          builder: (_) => DetailedItem(data: args),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('error'),
        ),
      );
    });
  }
}
