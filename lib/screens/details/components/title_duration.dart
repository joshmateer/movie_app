import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'package:intl/intl.dart';

class TitleDuration extends StatefulWidget {
  const TitleDuration({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movi movie;

  @override
  State<TitleDuration> createState() => _TitleDurationState();
}

class _TitleDurationState extends State<TitleDuration> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title!,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    Text(
                      '${DateFormat('MMMM d, yyyy').format(widget.movie.releaseDate!)}',
                      style: TextStyle(color: kTextLightColor),
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      widget.movie.contentRating ?? '',
                      style: TextStyle(color: kTextLightColor),
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      widget.movie.runtimeStr ?? '-',
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 64,
            width: 64,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  widget.movie.toggleFavoriteStatus(
                      FirebaseAuth.instance.currentUser!.uid);
                });
              },
              color: widget.movie.isFavorite
                  ? Theme.of(context).canvasColor
                  : kSecondaryColor,
              shape: widget.movie.isFavorite
                  ? CircleBorder(
                      side: BorderSide(width: 2, color: kSecondaryColor))
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
              child: widget.movie.isFavorite
                  ? Icon(
                      Icons.check_rounded,
                      size: 28,
                      color: kSecondaryColor,
                    )
                  : Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.white,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
