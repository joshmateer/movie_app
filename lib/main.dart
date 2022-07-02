import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/auth/auth_screen.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Movies(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: ThemeData(
            canvasColor: Colors.white,
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnap) {
                if (userSnap.hasData) {
                  return HomeScreen();
                }
                return AuthScreen(
                  isLogin: true,
                );
              }),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(
                  isLogin: true,
                ),
          },
        ));
  }
}
