import 'package:flutter/material.dart';
import 'package:movie_app/screens/charts/charts_screen.dart';
import 'package:movie_app/screens/feed/feed_screen.dart';
import 'package:movie_app/screens/subscriptions/subscriptions_page.dart';
import 'categories.dart';
import 'full_carousel.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.filters}) : super(key: key);
  List<String> filters; 

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryList(controller: controller),
        
        Container(
          child: Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                FullCarousellScreen(
                  isManage: false,
                  filters: widget.filters,
                ),
                FeedScreen(),
                //TicketsScreen(),
                SubscriptionsScreen(),
                ChartsScreen(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
