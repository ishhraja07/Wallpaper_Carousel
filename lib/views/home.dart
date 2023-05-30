import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/views/search.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;
import '../model/categories_model.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories= <CategoriesModel>[];
  List<WallpaperModel> wallpapers=<WallpaperModel>[];
  TextEditingController searchController= new TextEditingController();

  getTrendingWallpapers() async{

    Uri u = Uri.parse("https://api.pexels.com/v1/curated?per_page=80");
    var response=await http.get(u,
    headers: {
      "Authorization": 'IOeePkMTtfFhOrU01ETQjLSZoc5WEGWpbrgnTGhY2KnkzzgZg8KE0Pu8'
    });
    Map<String,dynamic> jsonData=jsonDecode(response.body);
    jsonData["photos"].forEach(
        (element){
          // print(element);
          WallpaperModel wallpaperModel= new WallpaperModel();
          wallpaperModel=WallpaperModel.fromJson(element);
          wallpapers.add(wallpaperModel);
        }
    );
    setState(() {

    });
  }
  @override
  void initState(){
    getTrendingWallpapers();
    setState(() {

    });
    categories=getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: brandName(
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
               margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "search wallpapers",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(
                      searchQuery: searchController.text,
                    )
                    ));
                  },
                    child: Container(
                        child: Icon(Icons.search)))
              ],),
            ),
            SizedBox(height: 16,),
            Container(
              height: 80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){

                  return CategoriesTile(
                      title: categories[index].categoriesName, imgUrl: categories[index].imgUrl);
                  }),
            ),
             wallpapersList(context: context, wallpapers: wallpapers,
             )
          ],
        ),
    ),
      ),
    );
  }
}
class CategoriesTile extends StatelessWidget {
  final String imgUrl,title;
  CategoriesTile({required this.title,required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: 4),
      child: Stack(children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imgUrl,height: 50,width: 100,fit: BoxFit.cover)),
        Container(

              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50, width: 100,
              alignment: Alignment.center,
            child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 15),)),
      ],),
    );
  }
}

