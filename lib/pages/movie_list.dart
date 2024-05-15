import 'package:flutter/material.dart';
import 'package:http_request/API/http_service.dart';

class movieList extends StatefulWidget {
  const movieList({super.key});

  @override
  State<movieList> createState() => _movieListState();
}

class _movieListState extends State<movieList> {
  int? moviesCount = 0;
  List? movie;
  HttpService? service;

  Future initialize() async {
    movie = [];
    movie = await service?.getPopularMovies();
    setState(() {
      moviesCount = movie!.length;
      movie = movie;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: movie!.isEmpty ? Container(child: Text("Loading..."),) : ListView.builder(
        itemCount: moviesCount,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Image(image: NetworkImage(movie![position].posterpath)),
              title: Text(movie![position].title),
              subtitle: Text('Rating = ' + movie![position].voteaverage.toString()),
            ),
          );
        },
      ),
    );
  }
}
