// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'HarryPotterBookPage.dart';
import 'HarryPotterCharactersPage.dart';

class HarryPotterHomePage extends StatefulWidget {
  const HarryPotterHomePage({super.key});

  @override
  State<HarryPotterHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HarryPotterHomePage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Harry Potter App"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Books"),
              Tab(text: "Characters"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HarryPotterBookPage(),
            HarryPotterCharactersPage(),
          ],
        ),
      ),
    );
  }
}
