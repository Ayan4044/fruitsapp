import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../model/Movies.dart';





  Future<Movies> getMovies() async {
    var client = http.Client();
    var moviesModel;

    try {

      var response = await client.get(Uri.parse("https://www.omdbapi.com/?i=tt3896198&apikey=82b99e87&s=Batman&page=1"));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        debugPrint("Res: ${jsonString}");
        moviesModel = Movies.fromJson(jsonMap);
      }
    } catch (ex ) {
      debugPrint("Exception: $ex");
      return moviesModel;
    }

    return moviesModel;
  }

