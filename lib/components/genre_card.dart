import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';

class GenreCard extends StatefulWidget {
  GenreCard({
    Key? key,
    required this.genre,
    this.filters,
  }) : super(key: key);
  final String genre;
  List<String>? filters;

  @override
  State<GenreCard> createState() => _GenreCardState();
}

class _GenreCardState extends State<GenreCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _setSelected() {
      if (widget.filters != null) {
        if (widget.filters!.contains(widget.genre)) {
          widget.filters!.removeWhere((filter) => filter == widget.genre);
          if (widget.filters!.isNotEmpty) {
            Provider.of<Movies>(context, listen: false)
                .filterTitles(widget.filters!);
          } else if (widget.filters!.isEmpty) {
            Provider.of<Movies>(context, listen: false).fetchAndSetMovies();
          }
        } else if (!widget.filters!.contains(widget.genre)) {
          widget.filters!.add(widget.genre);
          Provider.of<Movies>(context, listen: false)
              .filterTitles(widget.filters!);
        }
      }
    }

    return GestureDetector(
      onTap: () {
        _setSelected();
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: kDefaultPadding, bottom: 1),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 5,
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 1, color: Colors.black26, offset: Offset(1, 1))
            ],
            color: widget.filters == null
                ? Theme.of(context).canvasColor
                : widget.filters!.contains(widget.genre)
                    ? kTextColor
                    : Theme.of(context).cardColor,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.genre,
          style: TextStyle(
            fontWeight: widget.filters == null
                ? FontWeight.normal
                : widget.filters!.contains(widget.genre)
                    ? FontWeight.normal
                    : FontWeight.normal,
            color: widget.filters == null
                ? kTextColor.withOpacity(0.8)
                : widget.filters!.contains(widget.genre)
                    ? Colors.white
                    : kTextColor.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
