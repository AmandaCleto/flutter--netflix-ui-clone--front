import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeTab = 0;

  List bottomIcons = [
    {
      "path": 'assets/icons/bottombar-home.svg',
      "path-active": 'assets/icons/bottombar-home-active.svg',
      "text": "Inicio"
    },
    {
      "path": 'assets/icons/bottombar-coming-soon.svg',
      "path-active": 'assets/icons/bottombar-coming-soon-active.svg',
      "text": "Em breve"
    },
    {
      "path": 'assets/icons/bottombar-download.svg',
      "path-active": 'assets/icons/bottombar-download-active.svg',
      "text": "Dowloads"
    },
  ];

  // String teste = 'assets/icons/teste.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: bottomNavigationBarWidget(),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Row(
              children: [bodyWidget()],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget() {
    return IndexedStack(
      index: activeTab,
      children: [
        Center(
          child: Text(
            'HOME',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Center(
          child: Text(
            'Em breve',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Center(
          child: Text(
            'Dowloads',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget bottomNavigationBarWidget() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFF171717),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(bottomIcons.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() => {activeTab = index, print(index)});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 1.5),
                    child: SvgPicture.asset(
                      index == activeTab
                          ? bottomIcons[index]['path-active']
                          : bottomIcons[index]['path'],
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    bottomIcons[index]['text'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

 // SvgPicture.network(
  //   uriNames[1],
  //   placeholderBuilder: (context) =>
  //       CircularProgressIndicator(),
  //   height: 128.0,
  // ),
  // // SvgPicture.asset('assets/icons/teste.svg'),
  // SvgPicture.asset(
  //   'assets/icons/bottombar-coming-soon.svg',
  //   height: 30.0,
  //   width: 30.0,
  //   allowDrawingOutsideViewBox: true,
  // ),