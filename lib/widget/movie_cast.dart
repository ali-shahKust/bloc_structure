import 'package:flutter/material.dart';
import 'package:youtube_downloader/cons/bloc_cons.dart';
import 'package:youtube_downloader/cons/movie_const.dart';
import 'package:youtube_downloader/model/cast_response.dart';
import 'package:youtube_downloader/model/person_response.dart';
import 'package:youtube_downloader/utills/utills.dart';
import 'package:youtube_downloader/widget/cached_image.dart';
import 'package:youtube_downloader/widget/i_text.dart';

import 'loader.dart';

class MovieCastWidget extends StatefulWidget {
  int movieId;

  MovieCastWidget({required this.movieId});

  @override
  State<MovieCastWidget> createState() => _MovieCastWidgetState();
}

class _MovieCastWidgetState extends State<MovieCastWidget> {
  @override
  void initState() {
    movieCasts.getCastList(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieCasts.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<CastResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) {
            return Center(
              child: PrimaryText("Something went Wrong"),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.casts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Material(
                      elevation: 1.2,
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32)),
                            child: CachedImage(
                                url: imageBaseUrl +
                                    snapshot.data!.casts[index].img,
                                width: getscreenWidth(context) / 2.2,
                                height: getscreenHeight(context) / 3.2),
                          ),
                          PrimaryText(snapshot.data!.casts[index].name),
                          PrimaryText(snapshot.data!.casts[index].character),
                        ],
                      ),
                    ),
                  );
                });
          }
        } else {
          return const Center(
            child: LoaderIndicator(),
          );
        }
      },
    );
  }
}
