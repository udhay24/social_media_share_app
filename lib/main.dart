import 'package:flutter/material.dart';
import 'package:social_media_share_app/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          snackBarTheme: SnackBarThemeData(
              backgroundColor: Colors.black,
              actionTextColor: Colors.blueAccent,
              contentTextStyle: TextStyle(color: Colors.purpleAccent[700]),
              elevation: 10,
              shape: RoundedRectangleBorder(),
              )),
      home: HomeScreen(),
    );
  }
}
