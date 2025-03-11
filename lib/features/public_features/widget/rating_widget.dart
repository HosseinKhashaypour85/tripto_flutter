import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;
  bool changeRate;

   CustomRatingBar({super.key, required this.rating , required this.changeRate});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      minRating: 1,
      maxRating: 5,
      initialRating: rating,
      allowHalfRating: true,
      ignoreGestures: changeRate,
      ratingWidget: RatingWidget(
        full: const Icon(Icons.star, color: Colors.orange, size: 15,),
        half: const Icon(Icons.star_half, color: Colors.orange , size: 15,),
        empty: const Icon(Icons.star_border, color: Colors.orange, size: 15,),
      ),
      onRatingUpdate: (value) {},
    );
  }
}
