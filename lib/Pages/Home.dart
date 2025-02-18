// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_json_serializable/Models/Book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> booksList = [];
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
      List<BookModel> books =
          jsonResponse.map((book) => BookModel.fromJson(book)).toList();
      setState(() {
        booksList = books;
      });
    } else {
      print("Failed to fetch books: ${response.statusCode}");
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
          "JSON SERIALIZABLE WITH GET API",
          style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: booksList.isEmpty
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
          : ListView.separated(
              itemBuilder: (context, index) {
                return BookView(model: booksList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: booksList.length,
            ),
    ));
  }
}

class BookView extends StatefulWidget {
  final BookModel model;

  const BookView({Key? key, required this.model}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          width: double.maxFinite,
          decoration: BoxDecoration(
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
                Image.network(
                  widget.model.cover,
                  height: 140,
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Book Name : ${widget.model.title}",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Release Date : ${widget.model.releaseDate}",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Pages : ${widget.model.pages}",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Description : ${widget.model.description}",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
