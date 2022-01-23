import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_clone_netflix/src/pages/home.dart';

import '../providers/bottomNavigationBar.dart';
import 'components/bottomNavigationBar.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<IndexPage> {
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
          Center(
            child: Text(
              'Em breve',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Downloads',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
