import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/home/components/search_page.dart';
import 'components/body.dart';
import 'components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';
import 'package:animations/animations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    final moviesProvider = Provider.of<Movies>(context, listen: false);
    moviesProvider.fetchAndSetMovies();
    moviesProvider.fetchImdbData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  List<String> filters = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Theme.of(context).canvasColor,
      appBar: buildAppBar(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Body(filters: filters),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      leading: Builder(builder: (ctx) {
        return IconButton(
          padding: EdgeInsets.only(left: kDefaultPadding),
          icon: SvgPicture.asset('assets/icons/menu.svg'),
          color: Colors.black,
          onPressed: () {
            Scaffold.of(ctx).openDrawer();
          },
        );
      }),
      actions: [
        OpenContainer(
          closedColor: Theme.of(context).canvasColor,
          closedElevation: 0,
          transitionDuration: Duration(milliseconds: 700),
          transitionType: ContainerTransitionType.fadeThrough,
          closedBuilder: (context, action) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SvgPicture.asset('assets/icons/search.svg'),
            );
          },
          openBuilder: (context, action) {
            var _movies = Provider.of<Movies>(context).imdbMoviesFilter;
            return SearchPage(movies: _movies, filters: filters);
          },
        )
      ],
    );
  }
}
