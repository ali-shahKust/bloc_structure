import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/model/movie_response.dart';
import 'package:youtube_downloader/repo/movie_repo.dart';

class PlayingMovies {
  final movieRepo = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  getNowPlaying() async {
    MovieResponse response = await movieRepo.getPlayingMovies();
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }
}
