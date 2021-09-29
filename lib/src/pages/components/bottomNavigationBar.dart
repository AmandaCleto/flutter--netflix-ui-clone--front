import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/bottomNavigationBar.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  static List bottomIcons = [
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

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, bottomNavigationBarProvider, child) {
        int activeTabProvider = bottomNavigationBarProvider.activeTab;

        return Container(
          height: 55,
          decoration: BoxDecoration(
            color: Color(0xFF171717),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(bottomIcons.length, (index) {
              return GestureDetector(
                onTap: () {
                  bottomNavigationBarProvider.updateActiveTab(index);
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
                          index == activeTabProvider
                              ? bottomIcons[index]['path-active']
                              : bottomIcons[index]['path'],
                          height: 16,
                          width: 16,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        bottomIcons[index]['text'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: index == activeTabProvider
                              ? Colors.white
                              : Color(0xFF8D8D8D),
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
      },
    );
  }
}
