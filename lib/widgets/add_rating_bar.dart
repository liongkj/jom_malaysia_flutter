import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddRatingBar extends StatelessWidget {
  const AddRatingBar(
    this.updateRating, {
    Key key,
  }) : super(key: key);
  final void Function(double) updateRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      initialRating: 3,
      onRatingUpdate: (double value) {
        updateRating(value);
      },
    );
  }
}
