import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class BackdropAndRating extends StatefulWidget {
  const BackdropAndRating({
    Key? key,
    required this.size,
    required this.movie,
  }) : super(key: key);

  final Size size;
  final Movi movie;
  //final Movie movie;

  @override
  State<BackdropAndRating> createState() => _BackdropAndRatingState();
}

class _BackdropAndRatingState extends State<BackdropAndRating> {
  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###,000');
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: //Text('How would you rate\n' '${widget.movie.title}?'),
                  RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'How would you rate\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextSpan(
                        text: '${widget.movie.title}?',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(widget.movie.image!),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    RatingBar.builder(
                        itemBuilder: (ctx, i) => Column(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/imdb_star_fill.svg"),
                                Text('${i + 1}')
                              ],
                            ),
                        initialRating: widget.movie.userRating == 0
                            ? 0
                            : widget.movie.userRating.toDouble(),
                        glowColor: kFillStarColor,
                        glowRadius: 2,
                        onRatingUpdate: (rating) {
                          setState(() {
                            widget.movie.setUserRating(rating.round());
                          });
                        },
                        itemCount: 10,
                        itemSize: 25,
                        updateOnDrag: true),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                            onPressed: () {
                              widget.movie.setUserRating(0);
                              Navigator.of(context).pop();
                              setState(() {});
                            },
                            child: Text(
                              'Remove',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.red),
                            )),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Done',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.lightBlue),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ));

    return Container(
      height: widget.size.height * 0.4,
      child: Stack(
        children: [
          Container(
            height: widget.size.height * 0.4 - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.movie.image!),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: widget.size.width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 50,
                    color: Color(0xFF12153D).withOpacity(0.2),
                  )
                ],
              ),
              child: widget.movie.releaseDate!.isAfter(DateTime.now())
                  //widget.movie.contentType == 'upcoming'
                  ? Center(
                      child: Text(
                      'Coming Soon',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w600),
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/imdb_star_fill.svg"),
                            SizedBox(
                              height: kDefaultPadding / 4,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: '${widget.movie.imDbRating ?? '-'}/',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(text: '10\n'),
                                  TextSpan(
                                      text: widget.movie.imDbRatingVotes != null
                                          ? '${numberFormat.format(double.parse(widget.movie.imDbRatingVotes!))}'
                                          : '-',
                                      style: TextStyle(
                                        color: kTextLightColor,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (widget.movie.userRating != 0)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: openDialog,
                                child: SvgPicture.asset(
                                    "assets/icons/imdb_star_fill.svg"),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '${widget.movie.userRating}/',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(text: '10\n'),
                                    TextSpan(
                                        text: 'Your Rating',
                                        style: TextStyle(
                                          color: kTextLightColor,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (widget.movie.userRating == 0)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: openDialog,
                                child: SvgPicture.asset(
                                    "assets/icons/imdb_star.svg"),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              Text(
                                'Rate This\n ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFF51CF66),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                '${widget.movie.metacriticRating ?? '-'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: kDefaultPadding / 4,
                            ),
                            Text(
                              'Metascore',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rating',
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white60),
              child: BackButton(),
            ),
          ),
        ],
      ),
    );
  }
}
