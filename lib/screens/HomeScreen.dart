import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitsapp/bloc/MoviesBloc.dart';

import '../model/Movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final moviesBloc = MoviesBloc();

  @override
  void initState() {

    moviesBloc.eventSink.add(MoviesAction.Fetch);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispos
    moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop();
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
      ),
      body: StreamBuilder<List<Search>>(
        stream: moviesBloc.movisStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var article = snapshot.data?[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2.0,
                    child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    article?.poster ?? "",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(article?.year.toString() ?? "0000"),
                                  Text(
                                    article?.title ?? "Movie Name",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "IMDB ID = ${article?.imdbID ?? ""}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ),
    );
  }
}
