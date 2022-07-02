import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isEdit = false;
  TextEditingController? _userController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  @override
  void initState() {
    _userController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userController!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = MediaQuery.of(context).size.width * 0.024;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: Text('Profile'),
        elevation: 0,
        actions: [
          if (!isEdit)
            FlatButton(
              onPressed: () {
                setState(() {
                  _emailController!.text =
                      FirebaseAuth.instance.currentUser!.email!;

                  isEdit = !isEdit;
                });
              },
              child: Text(
                'Edit',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          if (isEdit)
            FlatButton(
              onPressed: () {
                setState(() {
                  FirebaseAuth.instance.currentUser!
                      .updateEmail(_emailController!.text);
                  FirebaseAuth.instance.currentUser!
                      .updatePassword(_passwordController!.text);
                  isEdit = !isEdit;
                });
              },
              child: Text(
                'Save',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: defaultSize * 15,
                    color: kSecondaryColor,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: defaultSize * 14,
                        width: defaultSize * 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).canvasColor,
                              width: defaultSize * 0.8),
                          color: Colors.blueGrey,
                        ),
                      ),
                      if (!isEdit)
                        Text(
                          'Josh Mateer',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kTextColor),
                        ),
                      if (isEdit)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _userController,
                            decoration: InputDecoration(hintText: 'Username'),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      if (!isEdit)
                        Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: kTextLightColor),
                        ),
                      if (isEdit)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(hintText: 'Email'),
                          ),
                        ),
                      if (isEdit)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(hintText: 'Password'),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
