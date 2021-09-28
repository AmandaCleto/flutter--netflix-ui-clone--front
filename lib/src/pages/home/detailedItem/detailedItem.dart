import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/detaieldItemAppBar.dart';

class DetailedItem extends StatefulWidget {
  final dynamic data;
  const DetailedItem({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailedItem> createState() => _DetailedItemState();
}

class _DetailedItemState extends State<DetailedItem> {
  @override
  Widget build(BuildContext context) {
    var item = widget.data[0];
    var imgPath = widget.data[1];
    var size = MediaQuery.of(context).size;
    print(widget.data);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DetaieldItemAppBar(),
      ),
      body: Container(
        color: Colors.black,
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '$imgPath${item['backdrop_path']}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              item['title'],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
