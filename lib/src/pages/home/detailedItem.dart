import 'package:flutter/material.dart';

class DetailedItem extends StatelessWidget {
  final String data;
  const DetailedItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('oi'),
      ),
      body: Container(
        color: Colors.amber,
        child: Text(data),
      ),
    );
  }
}
