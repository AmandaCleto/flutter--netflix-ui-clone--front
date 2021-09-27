import 'package:flutter/material.dart';

import '../../../data/homeData.dart';
import 'bottomSheet.dart';

class Carousel extends StatefulWidget {
  final String title;
  final String imgPath;
  final String api;

  const Carousel({
    Key? key,
    required this.title,
    required this.imgPath,
    required this.api,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late String banner = '';
  //FutureEmphasis
  late Future<ApiHomeData> futureSubject;

  @override
  void initState() {
    super.initState();
    banner = widget.imgPath;
    futureSubject = homeDataFetch(widget.api);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.black,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<ApiHomeData>(
                future: futureSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Row(
                          children: snapshot.data!.results
                              .asMap()
                              .map(
                                (index, item) => MapEntry(
                                  index,
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => modalBottomSheet(
                                            context, item, banner),
                                        child: Container(
                                          margin: EdgeInsets.only(right: 6),
                                          width: 110,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '$banner${item['poster_path']}',
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFE0000),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
