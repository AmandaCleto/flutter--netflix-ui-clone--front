import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_clone_netflix/src/pages/home/soon/soon.dart';

import '../providers/bottomNavigationBar.dart';
import 'components/bottomNavigationBar.dart';
import 'home/home.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<IndexPage> {
  int teste = 0;
  bool testetrue = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: IndexedStack(
        index: provider.activeTab,
        children: [
          HomePage(),
          SoonPage(),
          Container(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  right: testetrue ? 0 : MediaQuery.of(context).size.width,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue[300],
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            testetrue = !testetrue;
                          });
                        },
                        child: const Text('2'),
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  left: testetrue ? MediaQuery.of(context).size.width : 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green[300],
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            testetrue = !testetrue;
                          });
                        },
                        child: const Text('1'),
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
