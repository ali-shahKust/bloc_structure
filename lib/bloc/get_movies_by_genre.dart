import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/model/movie_response.dart';
import 'package:youtube_downloader/repo/movie_repo.dart';

class MovieListByGenreBloc {
  final movieRepo = MovieRepository();
  final BehaviorSubject<MovieResponse?> _subject =
  BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse?> get subject => _subject;

  getMoviesByGenre(int id) async {
    MovieResponse response = await movieRepo.getMovieByGenre(id);
    _subject.sink.add(response);
  }
  void drainStream(){
    _subject.value = null;
  }
  @mustCallSuper
  dispose()async{
    await _subject.drain();
    _subject.close();
  }
}
