import 'package:flutter/material.dart';
import 'package:youtube_downloader/cons/bloc_cons.dart';
import 'package:youtube_downloader/cons/movie_const.dart';
import 'package:youtube_downloader/model/movie_detail_response.dart';
import 'package:youtube_downloader/utills/utills.dart';
import 'package:youtube_downloader/widget/cached_image.dart';
import 'package:youtube_downloader/widget/i_text.dart';
import 'package:youtube_downloader/widget/loader.dart';
import 'package:youtube_downloader/widget/movie_cast.dart';

class MovieDetailsScreen extends StatefulWidget {
  int id;

  MovieDetailsScreen({required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    movieDetailBloc.getMovieDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: movieDetailBloc.subject.stream,
        builder: (BuildContext context,
            AsyncSnapshot<MovieDetailResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return Center(
                child: PrimaryText(
                  "Something went wrong",
                  color: Colors.white,
                ),
              );
            } else {
              return SizedBox(
                width: getscreenWidth(context),
                height: getscreenHeight(context),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getscreenHeight(context) / 3,
                        width: getscreenWidth(context),
                        child: Stack(
                          children: [
                            CachedImage(
                              url: imageBaseUrl +
                                  snapshot.data!.movieDetail.backPoster,
                              height: getscreenHeight(context) / 3,
                              width: getscreenWidth(context),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                    const Color(0xff000000).withOpacity(1.0),
                                    const Color(0xff00000).withOpacity(0.0),
                                  ])),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: FittedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedImage(
                                        url: imageBaseUrl +
                                            snapshot.data!.movieDetail.poster,
                                        height: getscreenHeight(context) * 0.12,
                                        width: getscreenWidth(context) * 0.2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryText(
                                          snapshot.data!.movieDetail.title,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        PrimaryText(
                                          "Release Date: ${snapshot.data!.movieDetail.releaseDate}",
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            labelTextController("Overview",
                                snapshot.data!.movieDetail.overview),
                            const SizedBox(
                              height: 12,
                            ),
                            PrimaryText(
                              "Cast:",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                                width: getscreenWidth(context),
                                height: getscreenHeight(context) / 2.5,
                                child: MovieCastWidget(
                                    movieId: snapshot.data!.movieDetail.id))
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: LoaderIndicator(),
            );
          }
        },
      ),
    );
  }

  labelTextController(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
          label + ":",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          height: 12,
        ),
        PrimaryText(text)
      ],
    );
  }
}
