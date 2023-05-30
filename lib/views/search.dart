import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;
class Search extends StatefulWidget {
  final String ?searchQuery;
  Search({this.searchQuery});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery!);
    super.initState();
    searchController.text=widget.searchQuery!;
  }
  TextEditingController searchController= new TextEditingController();
  List<WallpaperModel> wallpapers=<WallpaperModel>[];
  getSearchWallpapers(String query) async{

    Uri u = Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80");
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
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black, // <-- SEE HERE
          ),
          backgroundColor: Colors.white38,
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
                            getSearchWallpapers(searchController.text);
                        },
                        child: Container(
                            child: Icon(Icons.search), ))
                  ],),
                ),
            SizedBox(
           height: 16
          ),
      wallpapersList(context: context, wallpapers: wallpapers)
              ],
            ),
          ),
        ),
      );
  }
}
