import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/model/cast_response.dart';
import 'package:youtube_downloader/repo/movie_repo.dart';

class CastBloc {
  final movieRepo = MovieRepository();
  final BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

  BehaviorSubject<CastResponse> get subject => _subject;

  getCastList(movieId)async {
    CastResponse response = await movieRepo.getCasts(movieId);
    _subject.sink.add(response);

  }

  dispose(){
    _subject.close();
  }
}