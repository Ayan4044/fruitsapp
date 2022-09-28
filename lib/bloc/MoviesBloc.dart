
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../model/Movies.dart';
import '../services/APIManager.dart';


enum MoviesAction {
  Fetch
}

class MoviesBloc{
  final _moviesController =
  StreamController<List<Search>>();

  StreamSink<List<Search>> get _moviesSink =>
      _moviesController.sink;

  Stream<List<Search>> get movisStream =>
      _moviesController.stream;

  final _eventStreamController = StreamController<MoviesAction>();

  StreamSink<MoviesAction> get eventSink => _eventStreamController.sink;

  Stream<MoviesAction> get eventStream => _eventStreamController.stream;

  MoviesBloc() {
    eventStream.listen((event) async {
      if (event == MoviesAction.Fetch) {
        Movies movies = await getMovies();
        debugPrint(movies.toString());
        try {
          _moviesSink.add(movies.search!);
        } catch (e) {
          debugPrint(e.toString());
          _moviesSink.addError("Something went wrong!!");
        }
      }
    });
  }


  void dispose() {
    _eventStreamController.close();
    _moviesController.close();

  }
}