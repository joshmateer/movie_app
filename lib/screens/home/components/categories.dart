import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key? key, this.controller}) : super(key: key);
  TabController? controller;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 60,
      child: TabBar(
        labelColor: kTextColor,
        unselectedLabelColor: kTextLightColor,
        labelStyle: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w600,
              color: kTextColor,
            ),
        indicator: UnderlineTabIndicator(
          insets: EdgeInsets.symmetric(horizontal: 30),
          borderSide: BorderSide(
            width: 3,
            color: kSecondaryColor,
          ),
        ),
        isScrollable: true,
        indicatorColor: kSecondaryColor,
        onTap: (index) {
          selectedCategory = index;
        },
        controller: widget.controller,
        tabs: [
          Tab(text: 'Home'),
          Tab(text: 'Following'),
          Tab(text: 'Subscriptions'),
          Tab(text: 'Charts'),
        ],
      ),
    );
  }
}
