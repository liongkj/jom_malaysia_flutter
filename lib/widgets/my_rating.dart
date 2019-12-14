import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/dimens.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  const Rating({
    @required this.rating,
    Key key,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      rating: rating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(
        horizontal: 0.8,
      ),
      itemSize: 14,
    );
  }
}
