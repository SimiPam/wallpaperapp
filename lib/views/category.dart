import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wallpaperapp/model/categories_model.dart';
import 'package:wallpaperapp/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/model/wallpaper_model.dart';
import 'package:wallpaperapp/data/data.dart';

class Categories extends StatefulWidget {
  final String categoryName;

  Categories({this.categoryName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
      wallpapers.add(wallpaperModel);

      setState(() {});
      //print(element);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallpapers(widget.categoryName);
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
                SizedBox(
                  height: 16,
                ),
                WallpapersList(wallpapers: wallpapers, context: context),
              ],
            ),
          ),
        ));
  }
}
