import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      children: [
        SubscriptionTile(
          size: size,
          image: 'assets/images/disney-logo-white.png',
          color: Color.fromARGB(255, 3, 46, 82),
          imageWidth: 150,
          platform: 'disney',
          arrow: Colors.white,
        ),
        SubscriptionTile(
          size: size,
          image: 'assets/images/prime-logo-white.png',
          color: Color.fromARGB(255, 4, 97, 139),
          imageWidth: 180,
          platform: 'amazon',
          arrow: Colors.white,
        ),
        SubscriptionTile(
          size: size,
          image: 'assets/images/netflix-logo-wide.png',
          color: Colors.black,
          imageWidth: 170,
          platform: 'netflix',
          arrow: Colors.red,
        ),
        SubscriptionTile(
          size: size,
          image: 'assets/images/apple-logo-full.png',
          color: Colors.black,
          imageWidth: 250,
          platform: 'apple',
          arrow: Colors.black,
        ),
        SubscriptionTile(
          size: size,
          image: 'assets/images/hulu-logo.png',
          color: Colors.green[50]!,
          imageWidth: 150,
          platform: 'hulu',
          arrow: Colors.green[500],
        ),
        SubscriptionTile(
          size: size,
          image: 'assets/images/hbo-logo.png',
          color: Colors.grey[50]!,
          imageWidth: 190,
          platform: 'hbo',
          arrow: Colors.purple[500],
        ),
        SubscriptionTile(
          size: size,
          image: 'assets/images/paramount-logo.png',
          color: Colors.grey[50]!,
          imageWidth: 150,
          platform: 'paramount',
          arrow: Colors.blue[500],
        ),
      ],
    ));
  }
}

class SubscriptionTile extends StatefulWidget {
  const SubscriptionTile({
    Key? key,
    required this.size,
    required this.image,
    required this.imageWidth,
    required this.color,
    required this.platform,
    this.arrow,
  }) : super(key: key);

  final Size size;
  final String image;
  final double imageWidth;
  final Color color;
  final String platform;
  final Color? arrow;

  @override
  State<SubscriptionTile> createState() => _SubscriptionTileState();
}

class _SubscriptionTileState extends State<SubscriptionTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final _movies = Provider.of<Movies>(context)
        .imdbMovies
        .where((movie) =>
            movie.platform!.toLowerCase() == widget.platform.toLowerCase())
        .toList();
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: widget.size.height * .19,
            width: widget.size.width,
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.black54,
                      offset: Offset(2, 2))
                ]),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Material(
                    color: Colors.transparent,
                    child: Image(
                      width: widget.imageWidth,
                      image: AssetImage(widget.image),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: widget.arrow,
                    )),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 5, top: 10, left: 10, bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black54,
                              offset: Offset(2, 2))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10))),
                    child: Row(
                      children: [
                        Text(
                          'Go to App',
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected == true)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: widget.color),
              ),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: (1 / 1.5)),
              itemCount: _movies.length,
              itemBuilder: (ctx, ind) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_movies[ind].image!),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center)),
              ),
            ),
          )
      ],
    );
  }
}
