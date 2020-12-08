import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperapp/model/categories_model.dart';
import 'package:wallpaperapp/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/model/wallpaper_model.dart';
import 'package:wallpaperapp/data/data.dart';

class Search extends StatefulWidget {
  final String searchQuery;

  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
  List<WallpaperModel> wallpapers = new List();
  List<CategoriesModel> categories = new List();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {"Authorization": apiKey});
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      //wallpapers.add(wallpaperModel);

      setState(() {});
      //print(element);
      wallpapers.add(wallpaperModel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSearchWallpapers(widget.searchQuery);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(27),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SearchBar(
                  searchController: searchController,
                  onTap: () {
                    getSearchWallpapers(searchController.text);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              WallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
