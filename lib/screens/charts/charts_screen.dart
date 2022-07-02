import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/current_boxoffice.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/models/top_250_film.dart';
import 'package:provider/provider.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<Movies>(context);
    final _top250Films = moviesProvider.top250films;
    final _top250TV = moviesProvider.top250TV;
    final _imdbMovies = moviesProvider.imdbMovies;
    final _currenBoxOffice = moviesProvider.currentBoxOffice;
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        SizedBox(height: 10),
        Text(
          'Weekend Box Office',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        BoxOfficeMoviePageView(size: size, data: _currenBoxOffice),
        SizedBox(height: 10),
        Text(
          'Top 250 Films',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        MoviePageView(size: size, data: _top250Films),
        SizedBox(height: 10),
        Text(
          'Top 250 TV Series',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        MoviePageView(size: size, data: _top250TV),
      ],
    );
  }
}

class MoviePageView extends StatelessWidget {
  const MoviePageView({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final List<Top250Film> data;

  @override
  Widget build(BuildContext context) {
    final pageController =
        PageController(initialPage: 0, viewportFraction: 0.9);
    return Container(
      height: size.height * .24,
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (ctx, ind) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey[200]!),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black38,
                          offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data[ind].image))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[ind].fullTitle,
                                  textScaleFactor: .8,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Divider(
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Text(
                                  data[ind].crew,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'imDb Rating: ${data[ind].imDbRating}',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: kFillStarColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        'Rank: ${data[ind].rank}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}

class BoxOfficeMoviePageView extends StatelessWidget {
  const BoxOfficeMoviePageView({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final List<BoxOfficeMovie> data;

  @override
  Widget build(BuildContext context) {
    final pageController =
        PageController(initialPage: 0, viewportFraction: 0.9);
    return Container(
      height: size.height * .24,
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (ctx, ind) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey[200]!),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black38,
                          offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data[ind].image!))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[ind].title!,
                                  textScaleFactor: .8,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Divider(
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Text(
                                  'Weekend Gross: ${data[ind].weekend}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Domestic Gross: ${data[ind].gross!}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'Weeks: ${data[ind].weeks!}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          )
                        ]),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        'Rank: ${data[ind].rank}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
