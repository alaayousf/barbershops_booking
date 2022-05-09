import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/color.dart';

class CardWidgets extends StatefulWidget {
  CardWidgets({
    Key? key,
    required this.isViewRating,
    this.isSearch = true,
    required this.barbers,
  }) : super(key: key);
  final bool isViewRating;
  final bool isSearch;
  QueryDocumentSnapshot<Map<String, dynamic>> barbers;

  @override
  State<CardWidgets> createState() => _CardWidgetsState();
}

class _CardWidgetsState extends State<CardWidgets> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    List<dynamic> arrayvalue = widget.barbers.get('rater') as List<dynamic>;
    return Container(
      padding:
          widget.isSearch ? const EdgeInsets.all(0) : const EdgeInsets.all(8),
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: CachedNetworkImage(
                width: 60,
                height: 60,
                imageUrl:
                widget.barbers.get('logo'),
                fit: BoxFit.cover,
                errorWidget: (context, _, i) => Container(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.barbers.get('shopName'),
              style: TextStyle(
                color: ColorConst.white,
                fontSize: 20,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RatingBar.builder(
              itemSize: 13,
              initialRating: 3,
              minRating: 1,
              ignoreGestures: widget.isViewRating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // Logger().e('Rating User');
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${arrayvalue.length} Votes',
              style: TextStyle(
                color: const Color(0xffD6D6D6),
                fontSize: 14,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
