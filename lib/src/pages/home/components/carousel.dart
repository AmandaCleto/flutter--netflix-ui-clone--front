import 'package:flutter/material.dart';

import '../../../data/homeData.dart';

class Carousel extends StatefulWidget {
  final String title;
  final String api;

  const Carousel({
    Key? key,
    required this.title,
    required this.api,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  //FutureEmphasis
  late Future<ApiHomeData> futureSubject;

  @override
  void initState() {
    super.initState();
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
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<ApiHomeData>(
                future: futureSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(children: [Text('iu')]);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
