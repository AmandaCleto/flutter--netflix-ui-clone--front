import 'package:flutter/material.dart';

class DatailedItem extends StatefulWidget {
  const DatailedItem({Key? key}) : super(key: key);

  @override
  _DatailedItemState createState() => _DatailedItemState();
}

class _DatailedItemState extends State<DatailedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        child: Text(
          'oii',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
