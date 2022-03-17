import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:youtube_downloader/bloc/bloc_cons.dart';
import 'package:youtube_downloader/model/movie.dart';
import 'package:youtube_downloader/model/movie_response.dart';
import 'package:youtube_downloader/repo/movie_const.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  int _currentPage = 0;
  late Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    playingMoviesBloc..getNowPlaying();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: playingMoviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.error.length >0 )
            return Center(
              child: Text(snapshot.data!.error),
            );
            else {
              return _movieWidget(snapshot.data);
            }
          }
          else {
            return Container();
          }

    });
  }

  Widget _movieWidget(MovieResponse? data) {
    List<Movie> movies = data!.movies;
    if(data.movies.isEmpty){
      return Text("No Movie Found");
    }
    else {
      return PageIndicatorContainer(
        child: PageView.builder(
            itemCount: movies.take(5).length, 
            allowImplicitScrolling: true,
            controller: _pageController,
            itemBuilder: (context, index){
          return Stack(
            
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3.5,
                  child: Image.network(imageBaseUrl+movies[index].poster,fit: BoxFit.cover,)),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(

                      begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xff000000).withOpacity(1.0),
                      Color(0xff00000).withOpacity(0.0),

                    ]
                  )
                ),
              )
            ],
          );
        }), length: movies.take(5).length,
      );
    }
  }
}
