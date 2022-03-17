import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:youtube_downloader/bloc/bloc_cons.dart';
import 'package:youtube_downloader/model/movie.dart';
import 'package:youtube_downloader/model/movie_response.dart';
import 'package:youtube_downloader/repo/movie_const.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    movieListBloc..getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: movieListBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          print("snapshotData ${snapshot.data}");
          if (snapshot.hasData) {
            if (snapshot.data!.hasError || snapshot.data!.error.isNotEmpty) {
              return Center(
                child: Text(
                  "ARGGG..1!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return _customWidget(snapshot.data);
            }
          } else {
            return Center(
              child: Text(
                "ARGGG..!",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        });
  }

  Widget _customWidget(MovieResponse? data) {
    List<Movie> movies = data!.movies;

    if (movies.isEmpty) {
      return const Center(
        child: Text(
          "No Movies found",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return CustomScrollView(
        slivers: [
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            imageBaseUrl + movies[index].poster,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 110,
                                  height: 20,
                                  child: Marquee(text:   movies[index].title,style: TextStyle(fontWeight: FontWeight.bold),
                                    scrollAxis: Axis.horizontal,

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    decelerationCurve: Curves.easeOut,),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade800,
                                    ),
                                    Text(movies[index].rating.toString())
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: movies.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4))
        ],
      );
    }
  }
}
