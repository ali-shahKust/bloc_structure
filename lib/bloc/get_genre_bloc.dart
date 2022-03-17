import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/model/genre_response.dart';
import 'package:youtube_downloader/repo/movie_repo.dart';

class GenreBloc {
  final movieRepo = MovieRepository();
  final BehaviorSubject<GenreResponse> _subject =
  BehaviorSubject<GenreResponse>();

  BehaviorSubject<GenreResponse> get subject => _subject;

  getMovies() async {
    GenreResponse response = await movieRepo.getGenres();
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }
}
