import 'package:flutter/material.dart';

import '../../../data/homeData.dart';
import '../../../data/detailedData.dart';
import '../../../data/creditData.dart';
import 'bottomSheet.dart';

class Carousel extends StatefulWidget {
  final String title;
  final String imgPath;
  final String apiSubject;
  final String apiBase;
  final String language;
  final String apiKey;
  final String movieDetail;
  final int limit;
  final bool top10;

  const Carousel({
    Key? key,
    required this.title,
    required this.imgPath,
    required this.apiSubject,
    required this.apiBase,
    required this.language,
    required this.apiKey,
    required this.movieDetail,
    this.top10: false,
    this.limit: 0,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late String imgPath = '';
  late String detailedApi = '';
  late String creditApi = '';
  late String movieDetail = '';

  //Futures
  late Future<ApiHomeData> futureSubject;
  late ApiDetailedData detailedData;
  late ApiCreditData creditData;

  @override
  void initState() {
    super.initState();
    imgPath = widget.imgPath;
    futureSubject =
        homeDataFetch(widget.apiSubject, widget.limit).then((value) {
      var teste = value.results.sublist(0, 10);
      // print(teste);
      return value;
    });
  }

  fetchDetailedApi(context, {required itemId}) async {
    detailedApi =
        '${widget.apiBase}${widget.movieDetail}$itemId?${widget.apiKey}${widget.language}';
    creditApi =
        '${widget.apiBase}${widget.movieDetail}$itemId/credits?${widget.apiKey}${widget.language}';

    detailedData = await detailedDataFetch(detailedApi);
    creditData = await creditDataFetch(creditApi);

    modalBottomSheet(context, imgPath, detailedData, creditData);
  }

  // List<dynamic> array = futureSubject.results;

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
                    print(snapshot.hasData);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Row(
                          children: snapshot.data!.results
                              .asMap()
                              .map((index, item) {
                                return MapEntry(
                                  index,
                                  GestureDetector(
                                    onTap: () {
                                      fetchDetailedApi(context,
                                          itemId: item['id']);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 6),
                                          width: 110,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '$imgPath${item['poster_path']}',
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        widget.top10
                                            ? Stack(
                                                children: [
                                                  Text(
                                                    (index + 1).toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 80,
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle.stroke
                                                        ..strokeWidth = 6
                                                        ..color = Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    (index + 1).toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 80,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(''),
                                      ],
                                    ),
                                  ),
                                );
                              })
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
