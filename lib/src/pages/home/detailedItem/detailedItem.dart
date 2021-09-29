import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          item['release_date'].substring(0, 4),
                          style: TextStyle(
                            color: Color(0xFF8D8D8D),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          item['adult']
                              ? 'assets/icons/range-18.svg'
                              : 'assets/icons/range-universal.svg',
                          height: 20,
                          width: 20,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
