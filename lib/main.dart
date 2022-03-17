import 'package:flutter/material.dart';
import 'package:youtube_downloader/view/movies_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor:  Color(0xff00000),
        appBarTheme: AppBarTheme(
          backgroundColor:  Color(0xff00000),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        )
      ),
      home: const MoviesScreen(),
    );
  }
}
