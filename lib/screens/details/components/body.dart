import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'backdrop_rating.dart';
import 'title_duration.dart';
import 'genres.dart';
import 'cast_and_crew.dart';
import 'package:expandable_text/expandable_text.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.movie}) : super(key: key);
  //final Movie movie;
  final Movi movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackdropAndRating(size: size, movie: movie),
          SizedBox(height: kDefaultPadding / 2),
          TitleDuration(movie: movie),
          BookTicketsButton(movie: movie),
          Genres(movie: movie),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
              horizontal: kDefaultPadding,
            ),
            child: Text(
              'Plot Summary',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ExpandableText(
              movie.plot!,
              expandText: 'See More',
              collapseText: 'See Less',
              expandOnTextTap: true,
              maxLines: 4,
              style: TextStyle(
                color: Color(0xFF737599),
              ),
            ),
          ),
          CastAndCrew(
            casts: movie.actorList!,
          ),
        ],
      ),
    );
  }
}

class BookTicketsButton extends StatelessWidget {
  const BookTicketsButton({Key? key, required this.movie}) : super(key: key);
  final Movi movie;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding:
                EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
            width: MediaQuery.of(context).size.width,
            child: movie.isStreaming == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Streaming now on',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Image(
                            image: AssetImage(movie.platform == 'netflix'
                                ? 'assets/images/netflix-logo-wide.png'
                                : movie.platform == 'amazon'
                                    ? 'assets/images/prime-video-logo-wide.png'
                                    : movie.platform == 'disney'
                                        ? 'assets/images/disney-logo.png'
                                        : movie.platform == 'hulu'
                                            ? 'assets/images/hulu-logo.png'
                                            : movie.platform == 'paramount'
                                                ? 'assets/images/paramount-logo.png'
                                                : movie.platform == 'apple'
                                                    ? 'assets/images/apple-tv-logo.png'
                                                    : 'assets/images/hbo-logo.png')),
                      )
                    ],
                  )
                : FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: kSecondaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text('BOOK TICKETS',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headline6!
                                .fontSize)),
                    color: Theme.of(context).canvasColor)));
  }
}
