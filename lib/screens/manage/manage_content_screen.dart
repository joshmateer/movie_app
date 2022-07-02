import 'package:flutter/material.dart';
import 'package:movie_app/components/screen_title.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/home/components/full_carousel.dart';
import 'package:movie_app/screens/manage/add_content_screen.dart';

class ManageContentScreen extends StatefulWidget {
  const ManageContentScreen({Key? key}) : super(key: key);

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
  @override
  Widget build(BuildContext context) {
    void callback() {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (ctx) => AddContentScreen(isNew: true)));
              },
              icon: Icon(
                Icons.add_rounded,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: Column(
        children: [
          ScreenTitleWidget(title: 'Manage Titles'),
          Expanded(
            child: FullCarousellScreen(
              isManage: true,
            ),
          ),
        ],
      ),
    );
  }
}
