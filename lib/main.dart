import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Pages/HarryPotter/HarryPotterHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.nunitoTextTheme(),
        useMaterial3: true,
      ),
      home: const HarryPotterHomePage(),
    );
  }
}