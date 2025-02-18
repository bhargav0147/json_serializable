
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../Models/HarryPotterCharactersModel.dart';

class HarryPotterCharactersPage extends StatefulWidget {
  const HarryPotterCharactersPage({super.key});

  @override
  State<HarryPotterCharactersPage> createState() => _HarryPotterCharactersPageState();
}

class _HarryPotterCharactersPageState extends State<HarryPotterCharactersPage> {
  List<HarryPotterCharactersModel> charactersList = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    var response = await http.get(Uri.parse("https://potterapi-fedeperin.vercel.app/en/characters"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<HarryPotterCharactersModel> characters = jsonResponse.map((character) => HarryPotterCharactersModel.fromJson(character)).toList();
      setState(() {
        charactersList = characters;
      });
    } else {
      print("Failed to fetch characters: ${response.statusCode}");
    }
    _refreshController.refreshCompleted();
  }

  void _onRefresh() async {
    await fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      header: const ClassicHeader(refreshStyle: RefreshStyle.Follow),
      child: charactersList.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: charactersList.length,
              itemBuilder: (context, index) {
                return CharacterView(model: charactersList[index]);
              },
            ),
    );
  }
}

class CharacterView extends StatelessWidget {
  final HarryPotterCharactersModel model;

  const CharacterView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: model.image,
                height: 100,
                width: 80,
                fit: BoxFit.cover,
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
                children: [
                  Text(
                    model.fullName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Nickname: ${model.nickname}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Interpreted by: ${model.interpretedBy}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Birthdate: ${model.birthdate}",
                    style: const TextStyle(fontSize: 14),
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