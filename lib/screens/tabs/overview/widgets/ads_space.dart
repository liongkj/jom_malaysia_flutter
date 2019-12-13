import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class AdsSpace extends StatelessWidget {
  const AdsSpace({
    Key key,
    this.categoryType,
  }) : super(key: key);

  final String categoryType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 8.0),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
