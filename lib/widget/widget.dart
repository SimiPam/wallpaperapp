import 'package:flutter/material.dart';
import 'package:wallpaperapp/model/wallpaper_model.dart';
import 'package:wallpaperapp/views/category.dart';
import 'package:wallpaperapp/views/image_view.dart';
import 'package:wallpaperapp/views/search.dart';

Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Wallpaper',
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      Text(
        'Hub',
        style: TextStyle(
            color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ],
  );

/*Rich text option

  return RichText(
    textAlign: TextAlign.right,
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );*/
}

Widget WallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map((e) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageView(
                          imgUrl: e.src.portrait,
                        )));
          },
          child: Hero(
            tag: e.src.portrait,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  e.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}

class SearchBar extends StatelessWidget {
  SearchBar({@required this.searchController, this.onTap});

  final TextEditingController searchController;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "search wallpaper",
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            child: Icon(
              Icons.search,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({@required this.imgUrl, @required this.title});
  final String imgUrl, title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(
              categoryName: title.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
