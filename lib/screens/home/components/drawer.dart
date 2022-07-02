import 'package:flutter/material.dart';
import 'package:movie_app/components/screen_title.dart';
import 'package:movie_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/screens/manage/manage_content_screen.dart';
import 'package:movie_app/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var title = '';
  var isSelected = false;
  var isStreaming = false;
  var platform = '';
  TextEditingController? textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<Movies>(context);
    final platforms = [
      'netflix',
      'disney',
      'amazon',
      'hulu',
      'apple',
      'paramount',
      'hbo',
    ];
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (ctx, setState) => AlertDialog(
                title: Text('Add imDb Title'),
                content: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      TextField(
                        controller: textController,
                        onTap: () {
                          textController!.clear();
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        textInputAction: TextInputAction.done,
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      RaisedButton(
                          child: Text('Streaming'),
                          color: isStreaming ? kSecondaryColor : Colors.grey,
                          onPressed: () {
                            setState(() {
                              isStreaming = !isStreaming;
                              platform = '';
                            });
                          }),
                      if (isStreaming)
                        Container(
                          width: 200,
                          height: 200,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: platforms.length,
                            itemBuilder: (ctx, ind) => GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    platform = platforms[ind];
                                  },
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: platform == platforms[ind]
                                          ? Colors.blue
                                          : Colors.white),
                                  child: Text(platforms[ind])),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                          child: Text('Add'),
                          onPressed: () {
                            movieProvider
                                .addImdbTitle(title, isStreaming, platform)
                                .then((_) => {
                                      setState(() {
                                        textController!.clear();
                                        isStreaming = false;
                                        platform = '';
                                      })
                                    });
                          })
                    ],
                  ),
                ),
              ),
            ));
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ScreenTitleWidget(title: 'Settings'),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading:
                    Icon(Icons.person, color: kSecondaryColor.withOpacity(0.9)),
                title: Text(
                  'Profile',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kTextColor),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => ProfileScreen()));
                },
              ),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: Icon(Icons.new_label,
                    color: kSecondaryColor.withOpacity(0.9)),
                title: Text(
                  'Tickets',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kTextColor),
                ),
                onTap: () {},
              ),
              // Divider(
              //   indent: 20,
              //   endIndent: 20,
              // ),
              // ListTile(
              //   leading:
              //       Icon(Icons.edit, color: kSecondaryColor.withOpacity(0.9)),
              //   title: Text(
              //     'Manage Titles',
              //     style: Theme.of(context).textTheme.subtitle1,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (ctx) => ManageContentScreen()));
              //   },
              // ),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    color: kSecondaryColor.withOpacity(0.9)),
                title: Text(
                  'Settings',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kTextColor),
                ),
                onTap: () {},
              ),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: Icon(Icons.edit_note,
                    color: kSecondaryColor.withOpacity(0.9)),
                title: Text(
                  'Add imDb Movie',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kTextColor),
                ),
                onTap: () {
                  openDialog();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: kSecondaryColor.withOpacity(0.9)),
              title: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: kTextColor),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
