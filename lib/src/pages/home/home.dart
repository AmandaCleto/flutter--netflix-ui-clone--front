import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> uriNames = <String>[
    'http://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
    'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/410.svg',
    'https://upload.wikimedia.org/wikipedia/commons/b/b4/Chess_ndd45.svg',
  ];

  // String teste = 'assets/icons/teste.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text("data1"),
                  SvgPicture.network(
                    uriNames[1],
                    placeholderBuilder: (context) =>
                        CircularProgressIndicator(),
                    height: 128.0,
                  ),
                  // SvgPicture.asset('assets/icons/teste.svg'),
                  SvgPicture.asset(
                    'assets/icons/bottombar-coming-soon.svg',
                    height: 30.0,
                    width: 30.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
