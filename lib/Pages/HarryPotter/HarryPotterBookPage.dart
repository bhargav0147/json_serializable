import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:http/http.dart' as http;
import '../../Models/HarryPotterBookModel.dart';

class HarryPotterBookPage extends StatefulWidget {
  const HarryPotterBookPage({super.key});

  @override
  State<HarryPotterBookPage> createState() => _HarryPotterBookPageState();
}

class _HarryPotterBookPageState extends State<HarryPotterBookPage> {
  List<HarryPotterBookModel> booksList = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    var response = await http.get(Uri.parse("https://potterapi-fedeperin.vercel.app/en/books"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<HarryPotterBookModel> books = jsonResponse.map((book) => HarryPotterBookModel.fromJson(book)).toList();
      setState(() {
        booksList = books;
      });
    } else {
      print("Failed to fetch books: ${response.statusCode}");
    }
    _refreshController.refreshCompleted();
  }

  void _onRefresh() async {
    await fetchBooks();
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) return 1;
    if (screenWidth < 600) return 2;
    if (screenWidth < 800) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      header: const ClassicHeader(refreshStyle: RefreshStyle.Follow),
      child: booksList.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemCount: booksList.length,
              itemBuilder: (context, index) {
                return BookView(model: booksList[index]);
              },
            ),
    );
  }
}

class BookView extends StatelessWidget {
  final HarryPotterBookModel model;

  const BookView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 1)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: model.cover,
                height: 140,
                width: 100,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      color: Colors.blue,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                  Text(
                    model.releaseDate,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${model.pages} Pages",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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