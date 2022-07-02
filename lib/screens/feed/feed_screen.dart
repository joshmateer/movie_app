import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/screens/details/detail_screen.dart';
import 'package:movie_app/screens/home/components/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  PageController? _controller;
  final list = ['1', '2', '3', '4', '5'];

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.95, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _movies = Provider.of<Movies>(context)
        .imdbMovies
        .where((mov) => mov.isFavorite == true)
        .toList();
    return Container(
        color: Colors.grey[50],
        child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          itemCount: _movies.length,
          itemBuilder: (ctx, ind) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_movies[ind].image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
