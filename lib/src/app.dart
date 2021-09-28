import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:ui_clone_netflix/src/routes/router.dart';

import 'provider/bottomNavigationBar.dart';
import 'pages/index.dart';
import 'pages/home/detailedItem/detailedItem.dart';

import './routes/router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade900, //transparent
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
      ),
    );
    return (MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'Flutter Todo List',
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.black,
          ),
        ),
      ),
    ));
  }
}
