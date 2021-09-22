import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/bottomNavigationBar.dart';
import 'components/bottomNavigationBar.dart';
import 'comingSoon/comingSoon.dart';
import 'home/home.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Row(
              children: [
                IndexedStack(
                  index: provider.activeTab,
                  children: [
                    HomePage(),
                    ComingSoonPage(),
                    Center(
                      child: Text(
                        'Dowloads',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
