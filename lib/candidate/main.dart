import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'master.dart';


class MyApp extends StatelessWidget {
  static String routeName = "/main_page";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Master(),
    );
  }
}