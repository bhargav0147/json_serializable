// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_json_serializable/Models/HarryPotterBookModel.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HarryPotterBookPage extends StatefulWidget {
  const HarryPotterBookPage({super.key});

  @override
  State<HarryPotterBookPage> createState() => _HomePageState();
}

class _HomePageState extends State<HarryPotterBookPage> {
  List<HarryPotterBookModel> booksList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    await Future.delayed(const Duration(seconds: 2));
    var response = await http
        .get(Uri.parse("https://potterapi-fedeperin.vercel.app/en/books"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<HarryPotterBookModel> books =
          jsonResponse.map((book) => HarryPotterBookModel.fromJson(book)).toList();
      setState(() {
        booksList = books;
      });
    } else {
      print("Failed to fetch books: ${response.statusCode}");
    }
    _refreshController.refreshCompleted();
  }

  void _onRefresh() async{
   fetchBooks();
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 1; // 1 column for small screens
    } else if (screenWidth < 600) {
      return 2; // 2 columns for medium screens
    } else if (screenWidth < 800) {
      return 3; // 3 columns for larger screens
    } else {
      return 4; // 4 columns for very large screens
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "HARRY POTTER COMICS",
          style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        header: const ClassicHeader(refreshStyle: RefreshStyle.Follow,),
        child: booksList.isEmpty
            ? const Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 2,
                  ),
                ),
              )
            : GridView.builder(
              physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context), // Responsive columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2
                  ),
                  itemCount: booksList.length,
                  itemBuilder: (context, index) {
                    return BookView(model: booksList[index]);
                  },
                ),
      ),
    ));
  }
}

class BookView extends StatefulWidget {
  final HarryPotterBookModel model;

  const BookView({Key? key, required this.model}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
double _getResponsiveFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 12; // Smaller font size for small screens
    } else if (screenWidth < 600) {
      return 14; // Medium font size for medium screens
    } else {
      return 16; // Larger font size for large screens
    }
  }
  @override
  Widget build(BuildContext context) {
    double fontSize = _getResponsiveFontSize(context);
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.model.cover,
                height: 140,
                width: 100,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                        child: SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2,
                value: progress.progress,
              ),
                        ),
                      );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.model.title,
                    style:  TextStyle(
                      letterSpacing: 0.5,
                      color: Colors.black,
                      fontSize: fontSize,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,

                    ),
                    maxLines: 2,
                  ),
                  Text(
                    widget.model.releaseDate,
                    style:  TextStyle(
                      letterSpacing: 0.5,
                      color: Colors.black,
                      fontSize: fontSize - 2,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${widget.model.pages} Pages",
                    style:  TextStyle(
                      letterSpacing: 0.5,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: fontSize - 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
