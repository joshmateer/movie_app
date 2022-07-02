import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/screens/details/detail_screen.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatefulWidget {
  MovieCard(
      {Key? key, required this.movie, required this.isManage, this.callback});
  final Movi movie;
  bool isManage;
  Function? callback;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: OpenContainer(
        openElevation: 0,
        openColor: Theme.of(context).canvasColor,
        closedColor: Theme.of(context).canvasColor,
        closedElevation: 0,
        transitionDuration: Duration(milliseconds: 700),
        closedBuilder: (context, action) => buildMovieCard(context),
        openBuilder: (context, action) => DetailsScreen(movie: widget.movie),
      ),
    );
  }

  Container buildMovieCard(BuildContext context) {
    var movieClass = Provider.of<Movies>(context);
    //var moviesList = movieClass.items;
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      )),
                  FlatButton(
                    onPressed: () {
                      //movieClass.deleteMovie(widget.movie.id!);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              )),
            ));

    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          Expanded(
            child:
                //Stack(children: [
                Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [kDefaultShadow],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.movie.image!))),
            ),
            // if (widget.isManage)
            //   Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         IconButton(
            //             onPressed: () {
            //               openDialog();
            //             },
            //             icon: Icon(Icons.delete, color: Colors.white, shadows: [
            //               Shadow(
            //                   blurRadius: 20,
            //                   color: Colors.black,
            //                   offset: Offset(0, 0))
            //             ])),
            //         IconButton(
            //             onPressed: () {
            //               // Navigator.of(context).push(MaterialPageRoute(
            //               //     builder: (ctx) => AddContentScreen(
            //               //         isNew: false, id: widget.movie.id)));
            //             },
            //             icon: Icon(Icons.edit, color: Colors.white, shadows: [
            //               Shadow(
            //                   blurRadius: 20,
            //                   color: Colors.black,
            //                   offset: Offset(0, 0))
            //             ])),
            //         IconButton(
            //             onPressed: () {},
            //             icon: Icon(Icons.hide_image,
            //                 color: Colors.white,
            //                 shadows: [
            //                   Shadow(
            //                       blurRadius: 20,
            //                       color: Colors.black,
            //                       offset: Offset(0, 0))
            //                 ])),
            //       ],
            //     ),
            //   ),
            //]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            //child: FittedBox(
            child: Text(
              widget.movie.title!,
              softWrap: true,
              maxLines: 2,
              textScaleFactor: 0.9,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            //),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.movie.releaseDate!.isAfter(DateTime.now()))
                Text(
                  '${DateFormat('MMMM d, yyyy').format(widget.movie.releaseDate!)}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              if (widget.movie.releaseDate!.isBefore(DateTime.now()))
                SvgPicture.asset(
                  'assets/icons/imdb_star_fill.svg',
                  height: 20,
                ),
              if (widget.movie.releaseDate!.isBefore(DateTime.now()))
                SizedBox(width: kDefaultPadding / 2),
              if (widget.movie.releaseDate!.isBefore(DateTime.now()))
                Text(
                  '${widget.movie.imDbRating ?? '-'}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              if (widget.movie.isFavorite) SizedBox(width: kDefaultPadding / 2),
              if (widget.movie.isFavorite)
                Icon(Icons.check_circle_outline_rounded,
                    color: kSecondaryColor, size: 20),
              // if (widget.movie.contentType == 'upcoming')
              //   Text(
              //     '${widget.movie.year}',
              //     style: Theme.of(context).textTheme.bodyText2,
              //   ),
              // if (widget.movie.contentType != 'upcoming')
              //   SvgPicture.asset(
              //     'assets/icons/imdb_star_fill.svg',
              //     height: 20,
              //   ),
              // if (widget.movie.contentType != 'upcoming')
              //   SizedBox(width: kDefaultPadding / 2),
              // if (widget.movie.contentType != 'upcoming')
              //   Text(
              //     '${widget.movie.imDbRating}',
              //     style: Theme.of(context).textTheme.bodyText2,
              //   ),
              // if (widget.movie.isFavorite) SizedBox(width: kDefaultPadding / 2),
              // if (widget.movie.isFavorite)
              //   Icon(Icons.check_circle_outline_rounded,
              //       color: kSecondaryColor, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
