import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/wallpaper_model.dart';
class Categorie extends StatefulWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers=<WallpaperModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
